import 'package:shetter_app/core/presentation/presentation.dart';

part 'button.freezed.dart';

class UButton extends StatelessWidget {
  const UButton({
    Key? key,
    required this.child,
    this.outline = false,
    this.style = const UButtonStyle(),
    required this.onPressed,
    this.onLongPress,
    this.icon,
  }) : super(key: key);

  factory UButton.outline({
    required Widget child,
    UButtonStyle style = const UButtonStyle(),
    required VoidCallback onPressed,
    VoidCallback? onLongPress,
    Widget? icon,
  }) {
    return UButton(
      child: child,
      style: style,
      onPressed: onPressed,
      onLongPress: onLongPress,
      icon: icon,
      outline: true,
    );
  }

  final Widget child;
  final bool outline;
  final UButtonStyle style;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    Widget cardChild = Padding(
      padding: style.padding ?? DesignConstants.paddingButton,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(
                color: context.iconColor,
                size: 17,
              ),
              child: icon!,
            ),
            SizedBox(
              width: 13,
            ),
          ],
          DefaultTextStyle(
            style: context.textTheme.button!,
            child: Center(child: child),
          ),
        ],
      ),
    );

    Widget cardDecoration;
    if (!outline) {
      cardDecoration = Material(
        color: style.backgroundColor ?? context.theme.primaryColor,
        shadowColor: style.shadowColor ?? Colors.black38,
        elevation: style.elevation ?? 2,
        borderRadius: style.borderRadius ?? DesignConstants.borderRadius,
        clipBehavior: Clip.antiAlias,
        child: cardChild,
      );
    } else {
      cardDecoration = Container(
        decoration: BoxDecoration(
          color: style.backgroundColor ?? context.theme.primaryColorDark,
          borderRadius: style.borderRadius ?? DesignConstants.borderRadius,
          border: Border.all(
            color: style.borderColor ?? context.theme.dividerColor,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: cardChild,
      );
    }

    return UPressable(
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: Padding(
        padding: style.margin ?? EdgeInsets.zero,
        child: cardDecoration,
      ),
    );
  }
}

@freezed
class UButtonStyle with _$UButtonStyle {
  const factory UButtonStyle({
    Color? backgroundColor,
    Color? shadowColor,
    double? elevation,
    Color? borderColor,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
  }) = _UButtonStyle;
}
