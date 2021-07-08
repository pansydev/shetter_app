import 'package:shetter_app/core/presentation/presentation.dart';

part 'card.freezed.dart';

class UCard extends StatelessWidget {
  const UCard({
    Key? key,
    required this.child,
    this.title,
    this.outline = false,
    this.style = const UCardStyle(),
    this.onPressed,
    this.onLongPress,
    this.clipBehavior = Clip.none,
  }) : super(key: key);

  factory UCard.outline({
    required Widget child,
    Widget? title,
    UCardStyle style = const UCardStyle(),
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Clip clipBehavior = Clip.none,
  }) {
    return UCard(
      child: child,
      title: title,
      style: style,
      onPressed: onPressed,
      onLongPress: onLongPress,
      clipBehavior: clipBehavior,
      outline: true,
    );
  }

  final Widget child;
  final Widget? title;
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
      cardChild = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: context.textTheme.subtitle2!,
            child: title!,
          ),
          SizedBox(height: 4),
          child,
        ],
      );
    }

    Widget cardChildWithPadding = Padding(
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
      cardDecoration = Container(
        decoration: BoxDecoration(
          color: style.backgroundColor ?? context.theme.primaryColorDark,
          borderRadius: style.borderRadius ?? DesignConstants.borderRadius,
          border: Border.all(
            color: style.borderColor ?? context.theme.dividerColor,
          ),
        ),
        clipBehavior: clipBehavior,
        child: cardChildWithPadding,
      );
    }

    return UPressable(
      onPressed: onPressed,
      onLongPress: onLongPress,
      isTransparent: false,
      child: Padding(
        padding: style.margin ?? EdgeInsets.zero,
        child: cardDecoration,
      ),
    );
  }
}

@freezed
class UCardStyle with _$UCardStyle {
  const factory UCardStyle({
    Color? backgroundColor,
    Color? shadowColor,
    double? elevation,
    Color? borderColor,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
  }) = _UCardStyle;
}
