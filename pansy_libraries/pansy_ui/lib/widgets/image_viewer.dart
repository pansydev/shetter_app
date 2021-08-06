import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:pansy_ui/pansy_ui.dart';

class UImageViewer extends StatefulWidget {
  const UImageViewer(
    this.images, {
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  final List<UImageProvider> images;
  final int selectedIndex;

  void show(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UImageViewer(
          images,
          selectedIndex: selectedIndex,
        ),
      ),
    );
  }

  @override
  _UImageViewerState createState() => _UImageViewerState();
}

class _UImageViewerState extends State<UImageViewer> {
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
    final provider = widget.images[index];
    ImageProvider image;

    if (provider is UNetworkImageProvider) {
      image = NetworkImage(provider.url);
    } else if (provider is UFileImageProvider) {
      image = FileImage(provider.file);
    } else {
      throw Exception('unknown image provider');
    }

    return PhotoViewGalleryPageOptions(
      imageProvider: image,
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 2,
      heroAttributes: PhotoViewHeroAttributes(tag: provider),
    );
  }
}
