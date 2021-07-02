import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';

abstract class PostInputMapper {
  static InputPostInput postInputToDto(PostInput postInput) {
    return InputPostInput(text: postInput.text);
  }
}
