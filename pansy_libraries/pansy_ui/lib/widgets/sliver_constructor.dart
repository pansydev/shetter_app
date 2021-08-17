import 'package:pansy_ui/pansy_ui.dart';

class USliverConstructor extends StatefulWidget {
  const USliverConstructor({
    Key? key,
    required this.children,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final List<Widget> children;
  final EdgeInsets padding;

  @override
  _USliverConstructorState createState() => _USliverConstructorState();
}

class _USliverConstructorState extends State<USliverConstructor> {
  @override
  Widget build(BuildContext context) {
    final children = widget.children.toList();

    if (widget.padding != EdgeInsets.zero) {
      for (var index = 0; index < widget.children.length; index++) {
        final child = widget.children[index];

        if (child is! SliverPadding) {
          children.replace(
            child,
            SliverPadding(
              padding: widget.padding.copyWith(
                top: index != 0 ? 0 : null,
                bottom: index != widget.children.length - 1 ? 0 : null,
              ),
              sliver: child,
            ),
          );
        }
      }
    }

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      slivers: children,
    );
  }
}
