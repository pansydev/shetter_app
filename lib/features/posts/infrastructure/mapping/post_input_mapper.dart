import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

abstract class PostInputMapper {
  static InputPostInput postInputToDto(PostInput postInput) {
    return InputPostInput(text: postInput.text);
  }
}
