import '../../pansy_ui.dart';

class UIconButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final iconButton = UPressable(
      style: UPressableStyle(
        backgroundColor: style.backgroundColor,
        borderColor: style.borderColor,
        margin: style.margin,
        padding: style.padding ?? DesignConstants.padding7,
        borderRadius: style.borderRadius,
      ),
      showBorder: true,
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: icon,
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: iconButton);
    } else {
      return iconButton;
    }
  }
}

class UIconButtonStyle {
  const UIconButtonStyle({
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
