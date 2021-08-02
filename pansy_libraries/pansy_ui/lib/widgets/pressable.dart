import 'package:pansy_ui/pansy_ui.dart';

const Duration _animationDuration = Duration(milliseconds: 300);
const Curve _animationCurve = Curves.linearToEaseOut;

class UPressable extends StatefulWidget {
  const UPressable({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.curve = Curves.linearToEaseOut,
    this.duration = const Duration(milliseconds: 300),
    this.isTransparent = true,
    this.showBorder = false,
    this.style = const UPressableStyle(),
    this.enableFeedback = true,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Curve curve;
  final Duration duration;
  final bool isTransparent;
  final bool showBorder;
  final UPressableStyle style;
  final bool enableFeedback;

  @override
  _UPressableState createState() => _UPressableState();
}

class _UPressableState extends State<UPressable> {
  final _key = GlobalKey();
  bool pressabled = false;

  @override
  Widget build(BuildContext context) {
    final bool isTapEnabled =
        widget.onPressed != null || widget.onLongPress != null;

    return GestureDetector(
      onTapDown: isTapEnabled ? _onTapDown : null,
      onTapUp: _onTapUp,
      onTapCancel: () => _onTapUp(null),
      onTap: isTapEnabled
          ? () {
              if (widget.enableFeedback) {
                SystemSound.play(SystemSoundType.click);
              }
              widget.onPressed?.call();
            }
          : null,
      onLongPress: widget.onLongPress == null
          ? null
          : () {
              widget.onLongPress!();
              _onTapUp(null);
            },
      child: AnimatedContainer(
        key: _key,
        duration: _animationDuration,
        curve: _animationCurve,
        decoration: !pressabled || !widget.showBorder
            ? BoxDecoration(
                borderRadius:
                    widget.style.borderRadius ?? DesignConstants.borderRadius,
                border: Border.all(color: Colors.transparent),
              )
            : BoxDecoration(
                color: widget.style.backgroundColor ??
                    context.theme.primaryColorDark,
                borderRadius:
                    widget.style.borderRadius ?? DesignConstants.borderRadius,
                border: Border.all(
                  color: widget.style.borderColor ?? context.theme.dividerColor,
                ),
              ),
        margin: widget.style.margin ?? EdgeInsets.zero,
        padding: widget.style.padding ?? EdgeInsets.zero,
        child: AnimatedOpacity(
          duration: _animationDuration,
          curve: _animationCurve,
          opacity: widget.isTransparent && pressabled ? 0.5 : 1,
          child: UAnimatedScale(
            duration: _animationDuration,
            curve: _animationCurve,
            scale: pressabled ? _getScale() : 1,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  double _getScale() {
    if (_getAspectRatio() > 5) {
      return 0.92;
    } else {
      return 0.8;
    }
  }

  double _getAspectRatio() {
    final renderBox = _key.currentContext!.findRenderObject() as RenderBox?;
    return renderBox!.size.aspectRatio;
  }

  void _onTapDown(_) {
    setState(() {
      pressabled = true;
    });
  }

  void _onTapUp(_) {
    setState(() {
      pressabled = false;
    });
  }
}

class UPressableStyle {
  const UPressableStyle({
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
}
