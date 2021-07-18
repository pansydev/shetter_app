import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

@injectable
class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  PostFormBloc(this._postRepository)
      : super(
          PostFormState.initial(
            textController: TextEditingController(),
          ),
        );

  final PostRepository _postRepository;

  @override
  Stream<PostFormState> mapEventToState(PostFormEvent event) {
    return event.when(
      createPost: () => state.maybeWhen(
        initial: _auth,
        error: _auth,
        orElse: keep(state),
      ),
    );
  }

  Future<bool> createPost() async {
    add(PostFormEvent.createPost());
    await stream.firstWhere((element) => element is! PostFormStateLoading);

    return state is! PostFormStateError;
  }

  Stream<PostFormState> _auth(
    TextEditingController textController, [
    Failure? failure,
  ]) async* {
    yield PostFormState.loading(textController: textController);

    final result = await _postRepository.createPost(
      PostInput(text: textController.text),
    );

    yield result.fold(
      (l) {
        print(l);
        Get.snackbar(Strings.error.get(), l.toString());
        return PostFormState.error(
          textController: textController,
          failure: l,
        );
      },
      (r) {
        textController.clear();
        return PostFormState.initial(textController: textController);
      },
    );
  }

  @override
  Stream<Transition<PostFormEvent, PostFormState>> transformEvents(
    Stream<PostFormEvent> events,
    transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 100))
        .switchMap(transitionFn);
  }
}
