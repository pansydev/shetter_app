import 'package:shetter_app/core/presentation/presentation.dart';

part 'icon_button.freezed.dart';

const Duration _animationDuration = Duration(milliseconds: 200);
const Curve _animationCurve = Curves.ease;

class UIconButton extends StatefulWidget {
  const UIconButton(
    this.icon, {
    Key? key,
    required this.onPressed,
    this.onLongPress,
    this.style = const UIconButtonStyle(),
    this.tooltip,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final UIconButtonStyle style;
  final String? tooltip;

  @override
  _UIconButtonState createState() => _UIconButtonState();
}

class _UIconButtonState extends State<UIconButton> {
  bool pressabled = false;

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = IconTheme(
      data: IconThemeData(
        color: context.iconColor,
        size: 17,
      ),
      child: widget.icon,
    );

    Widget iconWidgetWidthPadding = Padding(
      padding: widget.style.margin ?? DesignConstants.padding,
      child: iconWidget,
    );

    Widget iconButton = Listener(
      onPointerDown: _onTapDown,
      onPointerUp: _onTapUp,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IgnorePointer(
            child: AnimatedOpacity(
              duration: _animationDuration,
              curve: _animationCurve,
              opacity: pressabled ? 1 : 0,
              child: UAnimatedScale(
                duration: _animationDuration,
                curve: _animationCurve,
                scale: pressabled ? 0.95 : 1,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: widget.style.backgroundColor ??
                        context.theme.primaryColorDark,
                    borderRadius: widget.style.borderRadius ??
                        DesignConstants.borderRadius,
                    border: Border.all(
                      color: widget.style.borderColor ??
                          context.theme.dividerColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          UPressable(
            onPressed: widget.onPressed,
            onLongPress: widget.onLongPress,
            child: iconWidgetWidthPadding,
          ),
        ],
      ),
    );

    if (widget.tooltip != null) {
      return Tooltip(message: widget.tooltip!, child: iconButton);
    } else {
      return iconButton;
    }
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
class UIconButtonStyle with _$UIconButtonStyle {
  const factory UIconButtonStyle({
    Color? backgroundColor,
    Color? borderColor,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
  }) = _UIconButtonStyle;
}
