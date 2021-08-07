import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

part 'post_form_state.freezed.dart';

@freezed
class PostFormState with _$PostFormState {
  const factory PostFormState.initial(
    PostEditingController postEditingController,
  ) = PostFormStateInitial;

  const factory PostFormState.loading(
    PostEditingController postEditingController,
  ) = PostFormStateLoading;

  const factory PostFormState.error(
    PostEditingController postEditingController, {
    required Failure failure,
  }) = PostFormStateError;
}
