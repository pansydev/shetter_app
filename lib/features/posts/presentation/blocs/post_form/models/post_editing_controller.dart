import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

@immutable
class PostEditingController {
  PostEditingController({
    this.editablePost,
    TextEditingController? textController,
    List<PostEditingImage>? images,
  })  : this.textController = textController ?? TextEditingController(),
        this.images = images ?? [];

  factory PostEditingController.editPost(Post post) {
    return PostEditingController(
      editablePost: post,
      textController: TextEditingController(
        text: post.currentVersion.textTokens.map((e) => e.text).join(),
      ),
      images: PostEditingImage.fromPostImagesList(post.currentVersion.images),
    );
  }

  final Post? editablePost;
  final TextEditingController textController;
  final List<PostEditingImage> images;

  UnmodifiableListView<File> getImagesForCreatePost() {
    return UnmodifiableListView(images.map((e) => e.fileImage!));
  }

  UnmodifiableListView<PostImageInput> getImagesForEditPost() {
    return UnmodifiableListView(
      images.map(
        (e) => PostImageInput(id: e.networkImage?.id, file: e.fileImage),
      ),
    );
  }

  void clear() {
    textController.clear();
    images.clear();
  }

  void addImages(List<File> files) {
    images.addAll(PostEditingImage.fromFilesList(files));
  }

  void removeImage(PostEditingImage file) {
    images.remove(file);
  }

  void reorderImage(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;

    final item = images.removeAt(oldIndex);
    images.insert(newIndex, item);
  }
}

@immutable
class PostEditingImage {
  const PostEditingImage({this.networkImage, this.fileImage});

  factory PostEditingImage.fromPostImage(PostImage postImage) =>
      PostEditingImage(networkImage: postImage);

  factory PostEditingImage.fromFile(File file) =>
      PostEditingImage(fileImage: file);

  static List<PostEditingImage> fromPostImagesList(List<PostImage> list) {
    return list.map((e) => PostEditingImage.fromPostImage(e)).toList();
  }

  static List<PostEditingImage> fromFilesList(List<File> list) {
    return list.map((e) => PostEditingImage.fromFile(e)).toList();
  }

  final PostImage? networkImage;
  final File? fileImage;
}
