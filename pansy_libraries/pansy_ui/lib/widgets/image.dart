import 'package:pansy_ui/pansy_ui.dart';

class UImage extends StatelessWidget {
  UImage(
    this.provider, {
    Key? key,
    this.style = const UImageStyle(),
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.hero = false,
    this.galleryImages = const [],
    this.onClose,
    this.onPressed,
  })  : assert(
          provider is UNetworkImageProvider || provider is UFileImageProvider,
          'invalid image provider',
        ),
        assert(
          !(galleryImages.isNotEmpty && onPressed != null),
          'onPressed incompatible with galleryImages',
        ),
        super(key: key);

  final UImageProvider provider;
  final UImageStyle style;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool hero;
  final List<UImageProvider> galleryImages;
  final VoidCallback? onClose;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (provider is UNetworkImageProvider) {
      image = Image.network(
        (provider as UNetworkImageProvider).url,
        width: width,
        height: height,
        fit: fit,
      );
    } else if (provider is UFileImageProvider) {
      image = Image.file(
        (provider as UFileImageProvider).file,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      throw Exception('unknown image provider');
    }

    Widget body = Stack(
      alignment: Alignment.topRight,
      children: [
        UCard(
          style: UCardStyle(
            backgroundColor: style.backgroundColor,
            shadowColor: style.shadowColor,
            elevation: style.elevation,
            padding: style.padding ?? EdgeInsets.zero,
            margin: style.margin,
            borderRadius: style.borderRadius,
          ),
          clipBehavior: Clip.antiAlias,
          child: image,
          onPressed: galleryImages.isEmpty
              ? null
              : () => UImageViewer(
                    galleryImages,
                    selectedIndex: galleryImages.indexOf(provider),
                  ).show(context),
        ),
        if (onClose != null)
          UChip.outline(
            style: UChipStyle(
              padding: DesignConstants.padding5,
              margin: DesignConstants.padding5,
            ),
            child: Icon(
              Icons.close,
              size: 15,
            ),
            onPressed: onClose,
          ),
      ],
    );

    if (hero) {
      return Hero(
        tag: provider,
        child: body,
      );
    } else {
      return body;
    }
  }
}

class UImageStyle {
  const UImageStyle({
    this.backgroundColor,
    this.shadowColor,
    this.elevation,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  final Color? backgroundColor;
  final Color? shadowColor;
  final double? elevation;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
}
