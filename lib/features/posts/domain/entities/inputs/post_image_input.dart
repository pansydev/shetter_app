import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post_image_input.freezed.dart';

@freezed
class PostImageInput with _$PostImageInput {
  factory PostImageInput({
    String? id,
    File? file,
  }) = _PostImageInput;
}
