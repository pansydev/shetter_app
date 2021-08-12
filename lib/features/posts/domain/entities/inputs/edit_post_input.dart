import 'package:shetter_app/features/posts/domain/domain.dart';

part 'edit_post_input.freezed.dart';

@freezed
class EditPostInput with _$EditPostInput {
  factory EditPostInput({
    required String text,
    required UnmodifiableListView<PostImageInput> images,
  }) = _EditPostInput;
}
