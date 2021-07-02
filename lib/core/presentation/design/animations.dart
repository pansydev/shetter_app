import 'package:shetter_app/core/presentation/presentation.dart';

const double _scrollPosition = 300;
const Duration _animationDuration = Duration(milliseconds: 300);

extension ScrollConrtollerAnimations on ScrollController {
  void scrollToUp() {
    jumpTo(_scrollPosition);
    animateTo(
      0,
      duration: _animationDuration,
      curve: Curves.ease,
    );
  }
}
