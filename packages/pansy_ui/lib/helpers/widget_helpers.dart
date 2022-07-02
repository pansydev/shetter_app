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

extension UWidgetIterableSliverExtensions on List<Widget> {
  List<Widget> get sliverBox => map((e) => e.sliverBox).toList();

  List<Widget> sliverPadding(EdgeInsets padding) {
    return map((e) => e.sliverPadding(padding)).toList();
  }

  List<Widget> get sliverPaddingZero {
    return map((e) => e.sliverPaddingZero).toList();
  }
}
