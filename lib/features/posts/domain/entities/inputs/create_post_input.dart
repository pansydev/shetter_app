import 'package:shetter_app/features/posts/domain/domain.dart';

part 'create_post_input.freezed.dart';

@freezed
class CreatePostInput with _$CreatePostInput {
  factory CreatePostInput({
    required String text,
    required UnmodifiableListView<File> images,
  }) = _CreatePostInput;
}
