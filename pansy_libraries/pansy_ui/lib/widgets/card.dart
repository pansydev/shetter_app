import 'package:pansy_ui/pansy_ui.dart';

class UCard extends StatelessWidget {
  const UCard({
    Key? key,
    this.child,
    this.children,
    this.scrollController,
    this.title,
    this.titleVariant = false,
    this.leading,
    this.trailing,
    this.outline = false,
    this.style = const UCardStyle(),
    this.onPressed,
    this.onLongPress,
  })  : assert(child != null || children != null, 'not specified widgets'),
        assert(!(child != null && children != null),
            'child incompatible with children'),
        assert(!(titleVariant && children != null),
            'titleVariant incompatible with children'),
        assert(!(titleVariant && title == null),
            'titleVariant not be without title'),
        assert(!(scrollController != null && children == null),
            'scrollController not be without children'),
        super(key: key);

  factory UCard.outline({
    Widget? child,
    List<Widget>? children,
    ScrollController? scrollController,
    Widget? title,
    bool titleVariant = false,
    Widget? leading,
    Widget? trailing,
    UCardStyle style = const UCardStyle(),
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
  }) {
    return UCard(
      title: title,
      leading: leading,
      trailing: trailing,
      style: style,
      onPressed: onPressed,
      onLongPress: onLongPress,
      outline: true,
      titleVariant: titleVariant,
      scrollController: scrollController,
      child: child,
      children: children,
    );
  }

  final Widget? child;
  final List<Widget>? children;
  final ScrollController? scrollController;
  final Widget? title;
  final bool titleVariant;
  final Widget? leading;
  final Widget? trailing;
  final bool outline;
  final UCardStyle style;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    Widget cardChild;

    if (title == null && children == null) {
      cardChild = child!;
    } else if (children != null) {
      cardChild = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            _UCardHeader(
              padding: style.padding ?? DesignConstants.padding,
              color: style.backgroundColor ??
                  (outline
                      ? context.theme.primaryColorDark
                      : context.theme.primaryColor),
              title: title!,
              leading: leading,
              trailing: trailing,
            ),
          Flexible(
            child: USliverConstructor(
              controller: scrollController,
              padding:
                  (style.padding ?? DesignConstants.padding).copyWith(top: 0),
              children: children!,
            ),
          ),
        ],
      );
    } else if (titleVariant) {
      cardChild = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _UCardHeader(
            padding: style.padding ?? DesignConstants.padding,
            color: style.backgroundColor ?? context.theme.primaryColor,
            title: title!,
            leading: leading,
            trailing: trailing,
          ),
          Padding(
            padding: (style.padding ?? DesignConstants.padding)
                .copyWith(top: 5, bottom: 10),
            child: child,
          ),
        ],
      );
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
                child!,
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

    final cardChildWithPadding = children != null || titleVariant
        ? cardChild
        : AnimatedContainer(
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
        clipBehavior: Clip.antiAlias,
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
          clipBehavior: Clip.antiAlias,
          child: cardChildWithPadding,
        ),
      );
    }

    return UPressable(
      onPressed: onPressed,
      onLongPress: onLongPress,
      isTransparent: false,
      child: AnimatedContainer(
        constraints: style.constraints,
        duration: 500.milliseconds,
        curve: Curves.linearToEaseOut,
        padding: style.margin ?? EdgeInsets.zero,
        child: cardDecoration,
      ),
    );
  }
}

class _UCardHeader extends StatelessWidget {
  const _UCardHeader({
    Key? key,
    required this.title,
    this.leading,
    this.trailing,
    this.padding = EdgeInsets.zero,
    this.color,
  }) : super(key: key);

  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var paddingAdaptive = padding;

    if (leading != null || trailing != null) {
      paddingAdaptive = padding.copyWith(
          bottom: 0, right: padding.right / 2, top: padding.top / 2);
    } else {
      paddingAdaptive = padding.copyWith(bottom: padding.bottom / 2);
    }

    return DefaultTextStyle(
      style: context.textTheme.subtitle2!,
      child: Container(
        padding: paddingAdaptive,
        decoration: BoxDecoration(color: color),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              SizedBox(width: 5),
            ],
            Expanded(child: title),
            if (trailing != null) ...[
              SizedBox(width: 5),
              trailing!,
            ],
          ],
        ),
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
    this.constraints,
  });

  final Color? backgroundColor;
  final Color? shadowColor;
  final double? elevation;
  final Color? borderColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final BoxConstraints? constraints;
}
