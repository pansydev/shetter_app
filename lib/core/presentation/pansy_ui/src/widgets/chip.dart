import '../../pansy_ui.dart';

class UChip extends StatelessWidget {
  const UChip({
    Key? key,
    required this.child,
    this.outline = false,
    this.style = const UChipStyle(),
    this.onPressed,
    this.onLongPress,
    this.icon,
  }) : super(key: key);

  factory UChip.outline({
    required Widget child,
    UChipStyle style = const UChipStyle(),
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? icon,
  }) {
    return UChip(
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
  final UChipStyle style;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    Widget cardChild = Padding(
      padding: style.padding ?? DesignConstants.paddingMini,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: context.theme.iconTheme.copyWith(
                size: 16,
              ),
              child: icon!,
            ),
            SizedBox(
              width: 11,
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
        borderRadius: style.borderRadius ?? DesignConstants.borderRadiusCircle,
        clipBehavior: Clip.antiAlias,
        child: cardChild,
      );
    } else {
      cardDecoration = Container(
        decoration: BoxDecoration(
          color: style.backgroundColor ?? context.theme.primaryColorDark,
          borderRadius:
              style.borderRadius ?? DesignConstants.borderRadiusCircle,
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

class UChipStyle {
  const UChipStyle({
    this.backgroundColor,
    this.shadowColor,
    this.elevation,
    this.borderColor,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  final Color? backgroundColor;
  final Color? shadowColor;
  final double? elevation;
  final Color? borderColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
}
