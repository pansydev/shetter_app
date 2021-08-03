import 'package:pansy_ui/pansy_ui.dart';

abstract class UDialogWidget extends StatelessWidget {
  const UDialogWidget({
    Key? key,
    this.title,
    this.outline = false,
  }) : super(key: key);

  final String? title;
  final bool outline;

  Widget buildBody({required Widget body}) => body;

  Future<T?> show<T>(BuildContext context) {
    if (!context.isDesktop) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (context) => buildBody(
          body: _UDialogWidgetContainerForPhone(
            child: _UDialogWidgetBody(
              title: title,
              outline: outline,
              body: this,
            ),
          ),
        ),
      );
    } else {
      return showCupertinoDialog<T>(
        context: context,
        barrierDismissible: true,
        builder: (context) => buildBody(
          body: _UDialogWidgetContainerForDesktop(
            child: _UDialogWidgetBody(
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

class _UDialogWidgetBody extends StatelessWidget {
  const _UDialogWidgetBody({
    Key? key,
    this.title,
    required this.outline,
    required this.body,
  }) : super(key: key);

  final String? title;
  final bool outline;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return UCard(
      title: Row(
        children: [
          SizedBox(width: DesignConstants.paddingMiniValue),
          if (title != null) Text(title!),
          Spacer(),
          UIconButton(
            Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      style: UCardStyle(
        margin: DesignConstants.padding10,
        borderRadius: DesignConstants.borderRadius,
        padding: DesignConstants.padding10,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              DesignConstants.paddingValue - DesignConstants.paddingMiniValue,
        ).copyWith(top: 3),
        child: body,
      ),
    );
  }
}
