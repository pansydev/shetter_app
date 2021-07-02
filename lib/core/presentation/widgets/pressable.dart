import 'package:shetter_app/core/presentation/presentation.dart';

class UPressable extends StatelessWidget {
  const UPressable({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.isTransparent = true,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      duration: 300.milliseconds,
      scaleMinValue: 0.8,
      opacityMinValue: isTransparent ? 0.5 : 1,
      scaleCurve: Curves.linearToEaseOut,
      opacityCurve: Curves.linearToEaseOut,
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: child,
    );
  }
}
