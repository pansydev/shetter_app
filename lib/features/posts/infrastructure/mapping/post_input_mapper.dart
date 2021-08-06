import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

abstract class PostInputMapper {
  static InputEditPostInput mapEditPostInputToDto(EditPostInput postInput) {
    return InputEditPostInput(
      text: postInput.text,
      images: UnmodifiableListView(postInput.images.map(
        (e) => e.id != null
            ? InputPostImageInput(id: e.id)
            : InputPostImageInput(
                file: MultipartFile.fromBytes("", e.file!.readAsBytesSync()),
              ),
      )),
    );
  }
}
