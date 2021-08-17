import 'package:pansy_ui/pansy_ui.dart';

extension UWidgetListExtensions on Widget {
  Iterable<Widget> operator *(int times) {
    return [this] * times;
  }
}

extension UWidgetSliverExtensions on Widget {
  Widget get sliverBox => SliverToBoxAdapter(child: this);

  SliverPadding sliverPadding(EdgeInsets padding) {
    return SliverPadding(padding: padding, sliver: this);
  }

  SliverPadding get sliverPaddingZero {
    return SliverPadding(padding: EdgeInsets.zero, sliver: this);
  }
}

extension UWidgetIterableSliverExtensions on Iterable<Widget> {
  Iterable<Widget> get sliverBox => map((e) => e.sliverBox);

  Iterable<Widget> sliverPadding(EdgeInsets padding) {
    return map((e) => e.sliverPadding(padding));
  }

  Iterable<Widget> get sliverPaddingZero => map((e) => e.sliverPaddingZero);
}
