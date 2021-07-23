import '../../pansy_ui.dart';

class UListTile extends StatelessWidget {
  const UListTile({
    Key? key,
    required this.child,
    this.icon,
    required this.onPressed,
    this.onLongPress,
    this.style = const UListTileStyle(),
    this.tooltip,
  }) : super(key: key);

  final Widget child;
  final Widget? icon;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final UListTileStyle style;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final listTile = ConstrainedBox(
      constraints: BoxConstraints(minHeight: DesignConstants.minListTileHeight),
      child: UPressable(
        style: UPressableStyle(
          backgroundColor: style.backgroundColor,
          borderColor: style.borderColor,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          borderRadius: style.borderRadius,
        ),
        showBorder: true,
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: DesignConstants.paddingValue),
            ],
            DefaultTextStyle(
              style: context.textTheme.button!,
              child: child,
            ),
          ],
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: listTile);
    } else {
      return listTile;
    }
  }
}

class UListTileStyle {
  const UListTileStyle({
    this.accentColor,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  final Color? accentColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
}
