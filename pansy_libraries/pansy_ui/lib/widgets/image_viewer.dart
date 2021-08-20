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
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => UImageViewer(
          images,
          selectedIndex: selectedIndex,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation.drive(0.0.tweenTo(1)),
            child: child,
          );
        },
      ),
    );
  }

  @override
  _UImageViewerState createState() => _UImageViewerState();
}

class _UImageViewerState extends State<UImageViewer> {
  late PageController _pageController;
  bool _interaction = false;
  int _currentPage = 1;

  void _pageUpdate(int value) {
    setState(() => _currentPage = value + 1);
  }

  void _interactionUpdate(bool value) {
    setState(() => _interaction = value);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.selectedIndex);
    _currentPage = widget.selectedIndex + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedContainer(
        duration: 300.milliseconds,
        curve: Curves.linearToEaseOut,
        color:
            _interaction ? Colors.black : context.theme.scaffoldBackgroundColor,
        child: Column(
          children: [
            _ImageViewerOverlay(
              title: PansyUILocalizations.of(context)
                  .localizations
                  .number_of_number(_currentPage, widget.images.length),
              show: !_interaction,
            ),
            Expanded(
              child: PageView.builder(
                physics: _interaction
                    ? NeverScrollableScrollPhysics()
                    : BouncingScrollPhysics(),
                controller: _pageController,
                itemBuilder: (_, index) => _ImageViewerItem(
                  widget.images[index],
                  onInteractionUpdate: _interactionUpdate,
                ),
                itemCount: widget.images.length,
                onPageChanged: _pageUpdate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageViewerOverlay extends StatelessWidget {
  const _ImageViewerOverlay({
    Key? key,
    required this.show,
    this.title,
  }) : super(key: key);

  final bool show;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return UAnimatedVisibility(
      visible: show,
      lazySize: false,
      child: SafeArea(
        child: Container(
          padding: DesignConstants.padding.copyWith(bottom: 0),
          constraints: BoxConstraints(
            maxWidth: context.designConstraints.maxPhoneWidth,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 45,
                child: UCard.outline(
                  style: UCardStyle(padding: DesignConstants.paddingMini),
                  onPressed: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: 15),
              if (title != null)
                Text(
                  title!,
                  style: context.textTheme.headline6,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageViewerItem extends StatefulWidget {
  const _ImageViewerItem(
    this.image, {
    Key? key,
    this.onInteractionUpdate,
  }) : super(key: key);

  final UImageProvider image;
  final void Function(bool)? onInteractionUpdate;

  @override
  _ImageViewerItemState createState() => _ImageViewerItemState();
}

class _ImageViewerItemState extends State<_ImageViewerItem> {
  final _transformationController = TransformationController();
  bool interaction = false;

  void _scaleUpdate(_) {
    setState(() {
      interaction = _transformationController.value.getMaxScaleOnAxis() > 1;
      widget.onInteractionUpdate?.call(interaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 1,
      transformationController: _transformationController,
      onInteractionUpdate: _scaleUpdate,
      child: Center(
        child: UImage(
          widget.image,
          style: UImageStyle(
            margin: !interaction ? DesignConstants.padding : EdgeInsets.zero,
            borderRadius:
                !interaction ? DesignConstants.borderRadius : BorderRadius.zero,
          ),
          hero: true,
        ),
      ),
    );
  }
}
