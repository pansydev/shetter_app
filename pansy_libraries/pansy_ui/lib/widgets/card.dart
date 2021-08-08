import 'package:pansy_ui/pansy_ui.dart';

class UCard extends StatelessWidget {
  const UCard({
    Key? key,
    required this.child,
    this.title,
    this.leading,
    this.trailing,
    this.outline = false,
    this.style = const UCardStyle(),
    this.onPressed,
    this.onLongPress,
    this.clipBehavior = Clip.none,
  }) : super(key: key);

  factory UCard.outline({
    required Widget child,
    Widget? title,
    Widget? leading,
    Widget? trailing,
    UCardStyle style = const UCardStyle(),
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Clip clipBehavior = Clip.none,
  }) {
    return UCard(
      child: child,
      title: title,
      leading: leading,
      trailing: trailing,
      style: style,
      onPressed: onPressed,
      onLongPress: onLongPress,
      clipBehavior: clipBehavior,
      outline: true,
    );
  }

  final Widget child;
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final bool outline;
  final UCardStyle style;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    Widget cardChild;

    if (title == null) {
      cardChild = child;
    } else {
      cardChild = Row(
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: 5),
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: context.textTheme.subtitle2!,
                  child: title!,
                ),
                SizedBox(height: 4),
                child,
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: 5),
            trailing!,
          ],
        ],
      );
    }

    Widget cardChildWithPadding = AnimatedContainer(
      duration: 500.milliseconds,
      curve: Curves.linearToEaseOut,
      padding: style.padding ?? DesignConstants.padding,
      child: cardChild,
    );

    Widget cardDecoration;
    if (!outline) {
      cardDecoration = Material(
        color: style.backgroundColor ?? context.theme.primaryColor,
        shadowColor: style.shadowColor ?? Colors.black38,
        elevation: style.elevation ?? 2,
        borderRadius: style.borderRadius ?? DesignConstants.borderRadius,
        clipBehavior: clipBehavior,
        child: cardChildWithPadding,
      );
    } else {
      cardDecoration = Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            color: style.backgroundColor ?? context.theme.primaryColorDark,
            borderRadius: style.borderRadius ?? DesignConstants.borderRadius,
            border: Border.all(
              color: style.borderColor ?? context.theme.dividerColor,
            ),
          ),
          clipBehavior: clipBehavior,
          child: cardChildWithPadding,
        ),
      );
    }

    return UPressable(
      onPressed: onPressed,
      onLongPress: onLongPress,
      isTransparent: false,
      child: AnimatedContainer(
        duration: 500.milliseconds,
        curve: Curves.linearToEaseOut,
        padding: style.margin ?? EdgeInsets.zero,
        child: cardDecoration,
      ),
    );
  }
}

class UCardStyle {
  const UCardStyle({
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
