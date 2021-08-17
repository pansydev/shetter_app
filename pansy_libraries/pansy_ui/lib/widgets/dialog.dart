import 'package:pansy_ui/pansy_ui.dart';

abstract class UDialogWidget extends StatelessWidget {
  const UDialogWidget({
    Key? key,
    this.title,
    this.outline = false,
  }) : super(key: key);

  final String? title;
  final bool outline;

  Widget buildBody(BuildContext context, {required Widget body}) => body;

  Future<T?> show<T>(BuildContext context) {
    final body = build(context);
    List<Widget>? slivers;

    if (body is USliverConstructor) {
      slivers = body.children;
    }

    if (!context.isDesktop) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (context) => buildBody(
          context,
          body: _UDialogWidgetContainerForPhone(
            child: _UDialogWidgetBodyDecorator(
              title: title,
              outline: outline,
              body: body,
              slivers: slivers,
            ),
          ),
        ),
      );
    } else {
      return showCupertinoDialog<T>(
        context: context,
        barrierDismissible: true,
        builder: (context) => buildBody(
          context,
          body: _UDialogWidgetContainerForDesktop(
            child: _UDialogWidgetBodyDecorator(
              title: title,
              outline: outline,
              body: this,
            ),
          ),
        ),
      );
    }
  }
}

class _UDialogWidgetContainerForPhone extends StatelessWidget {
  const _UDialogWidgetContainerForPhone({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.viewPadding.top,
        bottom: context.viewInsets.bottom,
      ),
      constraints: BoxConstraints(
        maxWidth: context.designConstraints.maxPhoneWidth,
      ),
      child: child,
    );
  }
}

class _UDialogWidgetContainerForDesktop extends StatelessWidget {
  const _UDialogWidgetContainerForDesktop({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: DesignConstants.padding,
        padding: EdgeInsets.only(
          top: context.viewPadding.top,
          bottom: context.viewInsets.bottom,
        ),
        constraints: BoxConstraints(
          maxWidth: context.designConstraints.maxPhoneWidth,
        ),
        child: child,
      ),
    );
  }
}

// TODO(cirnok): DraggableScrollableSheet
class _UDialogWidgetBodyDecorator extends StatelessWidget {
  const _UDialogWidgetBodyDecorator({
    Key? key,
    this.title,
    required this.outline,
    required this.body,
    this.slivers,
    this.padding,
  }) : super(key: key);

  final String? title;
  final bool outline;
  final Widget body;
  final List<Widget>? slivers;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return UCard(
      title: Text(title!),
      titleVariant: slivers == null,
      trailing: UIconButton(
        Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      style: UCardStyle(
        margin: DesignConstants.padding10,
        padding: padding,
      ),
      child: slivers == null ? body : null,
      children: slivers,
    );
  }
}
