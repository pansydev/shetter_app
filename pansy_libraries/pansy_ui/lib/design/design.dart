import 'package:pansy_ui/pansy_ui.dart';

class UDesign extends InheritedWidget {
  const UDesign({
    Key? key,
    this.constraints = const UDesignConstraints(),
    required Widget child,
  }) : super(key: key, child: child);

  final UDesignConstraints constraints;

  static UDesign of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<UDesign>();
    assert(result != null, 'No UDesign found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(UDesign oldWidget) =>
      constraints != oldWidget.constraints;
}
