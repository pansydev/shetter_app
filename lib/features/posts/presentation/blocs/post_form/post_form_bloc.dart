import 'package:image_picker/image_picker.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

@injectable
class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  PostFormBloc(this._postRepository)
      : super(
          PostFormState.initial(
            textController: TextEditingController(),
            images: UnmodifiableListView([]),
          ),
        );

  final PostRepository _postRepository;

  @override
  Stream<PostFormState> mapEventToState(PostFormEvent event) {
    return event.when(
      createPost: () => state.maybeWhen(
        initial: _createPost,
        error: _createPost,
        orElse: keep(state),
      ),
      updateImages: (images) => state.maybeMap(
        initial: (_) => _updatePhotos(images),
        error: (_) => _updatePhotos(images),
        orElse: keep(state),
      ),
    );
  }

  Future<bool> createPost() async {
    add(PostFormEvent.createPost());
    await stream.firstWhere((element) => element is! PostFormStateLoading);

    return state is! PostFormStateError;
  }

  void addImage({bool fromCamera = false}) async {
    final _picker = ImagePicker();

    List<XFile> images = [];

    if (fromCamera) {
      final result = await _picker.pickImage(source: ImageSource.camera);
      if (result != null) images.add(result);
    } else {
      final result = await _picker.pickMultiImage();
      if (result != null) images.addAll(result);
    }

    final imageFiles = images.map((e) => File(e.path)).toList();
    add(PostFormEvent.updateImages(
      UnmodifiableListView(
        state.images.toList() + imageFiles,
      ),
    ));
  }

  void removeImage(File image) {
    add(PostFormEvent.updateImages(
      UnmodifiableListView(
        state.images.toList()..remove(image),
      ),
    ));
  }

  void reorderImage(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final items = state.images.toList();
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);

    add(PostFormEvent.updateImages(
      UnmodifiableListView(items),
    ));
  }

  Stream<PostFormState> _createPost(
    TextEditingController textController,
    UnmodifiableListView<File> images, [
    Failure? failure,
  ]) async* {
    yield PostFormState.loading(textController: textController, images: images);

    final result = await _postRepository.createPost(
      CreatePostInput(
        text: textController.text,
        images: UnmodifiableListView(images),
      ),
    );

    yield result.match(
      (l) {
        return PostFormState.error(
          textController: textController,
          images: images,
          failure: l,
        );
      },
      () {
        textController.clear();
        return PostFormState.initial(
          textController: textController,
          images: images,
        );
      },
    );
  }

  Stream<PostFormState> _updatePhotos(
    UnmodifiableListView<File> images,
  ) async* {
    yield PostFormState.initial(
      textController: state.textController,
      images: images,
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
