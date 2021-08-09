import 'package:image_picker/image_picker.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

@injectable
class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  PostFormBloc(this._postRepository, @factoryParam Post? post)
      : super(
          PostFormState.initial(
            post != null
                ? PostEditingController.editPost(post)
                : PostEditingController(),
          ),
        );

  final PostRepository _postRepository;

  @override
  Stream<PostFormState> mapEventToState(PostFormEvent event) {
    return event.when(
      sendPost: () => state.maybeWhen(
        initial: _sendPost,
        error: _sendPost,
        orElse: keep(state),
      ),
      update: (postEditingController) => state.maybeMap(
        initial: (_) => _update(postEditingController),
        error: (_) => _update(postEditingController),
        orElse: keep(state),
      ),
    );
  }

  Future<bool> sendPost() async {
    add(PostFormEvent.sendPost());
    await stream.firstWhere((element) => element is! PostFormStateLoading);

    return state is! PostFormStateError;
  }

  Future<void> addImage({bool fromCamera = false}) async {
    if (state.postEditingController.images.length > 12) return;

    final _picker = ImagePicker();
    final images = <XFile>[];

    if (fromCamera) {
      final result = await _picker.pickImage(source: ImageSource.camera);
      if (result != null) images.add(result);
    } else {
      final result = await _picker.pickMultiImage();
      if (result != null) images.addAll(result);
    }

    if (images.length > 12) return;
    final imageFiles = images.map((e) => File(e.path)).toList();

    add(PostFormEvent.update(
      state.postEditingController..addImages(imageFiles),
    ));
  }

  void removeImage(PostEditingImage file) {
    add(PostFormEvent.update(
      state.postEditingController..removeImage(file),
    ));
  }

  void reorderImage(int oldIndex, int newIndex) {
    add(PostFormEvent.update(
      state.postEditingController..reorderImage(oldIndex, newIndex),
    ));
  }

  Stream<PostFormState> _sendPost(
    PostEditingController postEditingController, [
    Failure? failure,
  ]) async* {
    yield PostFormState.loading(postEditingController);

    Option<Failure> result;
    if (postEditingController.editablePost == null) {
      result = await _postRepository.createPost(
        CreatePostInput(
          text: postEditingController.textController.text,
          images: postEditingController.getImagesForCreatePost(),
        ),
      );
    } else {
      result = await _postRepository.editPost(
        postEditingController.editablePost!.id,
        EditPostInput(
          text: postEditingController.textController.text,
          images: postEditingController.getImagesForEditPost(),
        ),
      );
    }

    yield result.match(
      (l) {
        return PostFormState.error(
          postEditingController,
          failure: l,
        );
      },
      () {
        return PostFormState.initial(
          postEditingController..clear(),
        );
      },
    );
  }

  Stream<PostFormState> _update(
    PostEditingController newPostEditingController,
  ) async* {
    yield PostFormState.initial(
      PostEditingController(
        editablePost: newPostEditingController.editablePost,
        textController: newPostEditingController.textController,
        images: newPostEditingController.images,
      ),
    );
  }

  @override
  Stream<Transition<PostFormEvent, PostFormState>> transformEvents(
    Stream<PostFormEvent> events,
    transitionFn,
  ) {
    return events.debounceTime(100.milliseconds).switchMap(transitionFn);
  }
}
