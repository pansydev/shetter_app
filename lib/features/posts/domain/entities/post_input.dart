import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post_input.freezed.dart';

@freezed
class PostInput with _$PostInput {
  factory PostInput({
    required String text,
  }) = _PostInput;
}
