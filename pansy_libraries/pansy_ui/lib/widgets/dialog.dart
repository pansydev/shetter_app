import 'package:pansy_ui/pansy_ui.dart';

class UDialog extends StatelessWidget {
  const UDialog({
    Key? key,
    this.title,
    this.outline = false,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final String? title;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    final body = child;
    List<Widget>? slivers;
    ScrollController? controller;

    if (body is USliverConstructor) {
      slivers = body.children;
      controller = body.controller;
    }

    return _UDialogWidgetBodyDecorator(
      title: title,
      outline: outline,
      body: body,
      slivers: slivers,
      scrollController: controller,
    );
  }

  static Future<T?> show<T>(BuildContext context, Widget child) {
    if (!context.isDesktop) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (context) {
          return _UDialogWidgetContainerForPhone(
            child: child,
          );
        },
      );
    } else {
      return showCupertinoDialog<T>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return _UDialogWidgetContainerForDesktop(
            child: child,
          );
        },
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
    this.scrollController,
    this.padding,
  }) : super(key: key);

  final String? title;
  final bool outline;
  final Widget body;
  final List<Widget>? slivers;
  final ScrollController? scrollController;
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
      scrollController: scrollController,
      child: slivers == null ? body : null,
      children: slivers,
    );
  }
}
