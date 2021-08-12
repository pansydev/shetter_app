import 'package:pansy_ui/pansy_ui.dart';

extension UWidgetExtensions on Widget {
  Widget get sliverBox => SliverToBoxAdapter(child: this);
}
