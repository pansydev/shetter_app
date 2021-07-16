import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

part 'post_form_state.freezed.dart';

@freezed
class PostFormState with _$PostFormState {
  const factory PostFormState.initial({
    required TextEditingController textController,
  }) = PostFormStateInitial;

  const factory PostFormState.loading({
    required TextEditingController textController,
  }) = PostFormStateLoading;

  const factory PostFormState.error({
    required TextEditingController textController,
    required Failure failure,
  }) = PostFormStateError;
}
