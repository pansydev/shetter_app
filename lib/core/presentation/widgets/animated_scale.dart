import 'package:shetter_app/core/presentation/presentation.dart';

class AnimatedScale extends ImplicitlyAnimatedWidget {
  const AnimatedScale({
    Key? key,
    required this.child,
    required this.scale,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.alignment = Alignment.center,
  })  : assert(scale >= 0.0, "cannot be less than zero"),
        super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  final Widget child;
  final double scale;
  final Alignment alignment;

  @override
  _AnimatedScaleState createState() => _AnimatedScaleState();
}

class _AnimatedScaleState extends ImplicitlyAnimatedWidgetState<AnimatedScale> {
  Tween<double>? _scale;
  late Animation<double> _scaleAnimation;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _scale = visitor(_scale, widget.scale,
        (value) => Tween<double>(begin: value as double)) as Tween<double>?;
  }

  @override
  void didUpdateTweens() {
    _scaleAnimation = animation.drive(_scale!);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
      alignment: widget.alignment,
    );
  }
}
