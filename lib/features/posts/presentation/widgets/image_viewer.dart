import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer(
    this.images, {
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  final UnmodifiableListView<PostImage> images;
  final int selectedIndex;

  void show(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImageViewer(
          images,
          selectedIndex: selectedIndex,
        ),
      ),
    );
  }

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: _buildItem,
      itemCount: widget.images.length,
      pageController: _pageController,
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final image = widget.images[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(image.url),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 2,
      heroAttributes: PhotoViewHeroAttributes(tag: image.id),
    );
  }
}
