import 'package:flutter/services.dart';
import 'package:shetter_app/core/presentation/presentation.dart';

part 'pressable.freezed.dart';

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
  bool pressabled = false;

  @override
  Widget build(BuildContext context) {
    final bool isTapEnabled =
        widget.onPressed != null || widget.onLongPress != null;

    return Listener(
      onPointerDown: isTapEnabled ? _onTapDown : null,
      onPointerUp: isTapEnabled ? _onTapUp : null,
      child: GestureDetector(
        onTap: isTapEnabled
            ? () {
                if (widget.enableFeedback) {
                  SystemSound.play(SystemSoundType.click);
                }
                widget.onPressed?.call();
              }
            : null,
        onLongPress: widget.onLongPress,
        child: UAnimatedScale(
          duration: _animationDuration,
          curve: _animationCurve,
          scale: pressabled ? 0.95 : 1,
          child: AnimatedContainer(
            duration: _animationDuration,
            curve: _animationCurve,
            decoration: !pressabled || !widget.showBorder
                ? BoxDecoration(
                    borderRadius: widget.style.borderRadius ??
                        DesignConstants.borderRadius,
                    border: Border.all(color: Colors.transparent),
                  )
                : BoxDecoration(
                    color: widget.style.backgroundColor ??
                        context.theme.primaryColorDark,
                    borderRadius: widget.style.borderRadius ??
                        DesignConstants.borderRadius,
                    border: Border.all(
                      color: widget.style.borderColor ??
                          context.theme.dividerColor,
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
                scale: pressabled ? 0.8 : 1,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
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

@freezed
class UPressableStyle with _$UPressableStyle {
  const factory UPressableStyle({
    Color? backgroundColor,
    Color? borderColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
  }) = _UPressableStyle;
}
