import 'package:shetter_app/core/presentation/presentation.dart';

part 'icon_button.freezed.dart';

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

@freezed
class UIconButtonStyle with _$UIconButtonStyle {
  const factory UIconButtonStyle({
    Color? backgroundColor,
    Color? borderColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
  }) = _UIconButtonStyle;
}
