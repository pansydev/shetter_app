import 'package:pansy_ui/pansy_ui.dart';

const double _scrollPosition = 300;
const Duration _animationDuration = Duration(milliseconds: 300);

extension UScrollConrtollerAnimations on ScrollController {
  void scrollToUp() {
    if (offset > _scrollPosition) {
      jumpTo(_scrollPosition);
    }
    animateTo(
      0,
      duration: _animationDuration,
      curve: Curves.linearToEaseOut,
    );
  }
}
