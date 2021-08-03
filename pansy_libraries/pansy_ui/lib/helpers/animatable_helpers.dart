import 'package:pansy_ui/pansy_ui.dart';

extension UAnimatableExtensions<T> on Animatable<T> {
  Animation<T> animatedBy(AnimationController controller) {
    return animate(controller);
  }

  Animatable<T> curved(Curve curve) => chain(CurveTween(curve: curve));
}
