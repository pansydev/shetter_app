import 'dart:typed_data';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:image/image.dart' as img;
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
      final networkProvider = provider as UNetworkImageProvider;
      final url = networkProvider.url;
      final blurImage = networkProvider.blurHash != null
          ? Uint8List.fromList(
              img.encodeJpg(
                BlurHash.decode(networkProvider.blurHash!).toImage(30, 30),
              ),
            )
          : null;

      image = CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (_, __) {
          return Stack(
            alignment: Alignment.center,
            children: [
              if (blurImage != null)
                SizedBox(
                  width: width,
                  height: height,
                  child: Image.memory(
                    blurImage,
                    fit: fit,
                  ),
                ),
              if (blurImage == null)
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: context.theme.iconTheme.color,
                  ),
                ),
            ],
          );
        },
        errorWidget: (context, url, error) => Icon(Icons.error),
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

    final Widget body = Stack(
      alignment: Alignment.topRight,
      children: [
        Hero(
          tag: provider,
          child: UCard(
            style: UCardStyle(
              backgroundColor: style.backgroundColor,
              shadowColor: style.shadowColor,
              elevation: style.elevation,
              padding: style.padding ?? EdgeInsets.zero,
              margin: style.margin,
              borderRadius: style.borderRadius,
            ),
            onPressed: galleryImages.isEmpty
                ? null
                : () => UImageViewer(
                      galleryImages,
                      selectedIndex: galleryImages.indexOf(provider),
                    ).show(context),
            child: image,
          ),
        ),
        if (onClose != null)
          UChip.outline(
            style: UChipStyle(
              padding: DesignConstants.padding5,
              margin: DesignConstants.padding5,
            ),
            onPressed: onClose,
            child: Icon(
              Icons.close,
              size: 15,
            ),
          ),
      ],
    );

    return body;
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
