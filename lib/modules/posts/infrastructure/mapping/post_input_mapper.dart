import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/infrastructure/infrastructure.dart';

abstract class PostInputMapper {
  static Input$EditPostInput mapEditPostInputToDto(EditPostInput postInput) {
    return Input$EditPostInput(
      text: postInput.text,
      images: UnmodifiableListView(postInput.images.map(
        (e) => e.id != null
            ? Input$PostImageInput(id: e.id)
            : Input$PostImageInput(
                file: MultipartFile.fromBytes('', e.file!.readAsBytesSync()),
              ),
      )),
    );
  }
}
