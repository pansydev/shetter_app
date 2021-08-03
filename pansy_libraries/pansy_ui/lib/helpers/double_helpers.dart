import 'package:pansy_ui/pansy_ui.dart';

extension UDoubleAnimationExtensions on double {
  Tween<double> tweenTo(double end) => Tween<double>(begin: this, end: end);
}
