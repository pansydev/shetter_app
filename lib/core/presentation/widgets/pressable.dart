import 'package:shetter_app/core/presentation/presentation.dart';

class UPressable extends StatelessWidget {
  const UPressable({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.curve = Curves.linearToEaseOut,
    this.duration = const Duration(milliseconds: 300),
    this.isTransparent = true,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Curve curve;
  final Duration duration;
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      duration: duration,
      scaleMinValue: 0.8,
      opacityMinValue: isTransparent ? 0.5 : 1,
      scaleCurve: curve,
      opacityCurve: curve,
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: child,
    );
  }
}
