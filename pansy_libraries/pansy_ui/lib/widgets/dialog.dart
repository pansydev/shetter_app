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
        barrierColor: Colors.black45,
        builder: (context) => buildBody(
          body: _UDialogWidgetBodyForPhone(
            title: title,
            body: this,
            outline: outline,
          ),
        ),
      );
    } else {
      return showCupertinoDialog<T>(
        context: context,
        barrierDismissible: true,
        builder: (context) => buildBody(
          body: _UDialogWidgetBodyForDesktop(
            title: title,
            body: this,
            outline: outline,
          ),
        ),
      );
    }
  }
}

class _UDialogWidgetBodyForPhone extends StatelessWidget {
  const _UDialogWidgetBodyForPhone({
    Key? key,
    this.title,
    required this.body,
    required this.outline,
  }) : super(key: key);

  final String? title;
  final Widget body;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.viewInsets.top),
      constraints: BoxConstraints(
        maxWidth: context.designConstraints.maxPhoneWidth,
      ),
      child: UCard(
        title: Padding(
          padding: EdgeInsets.only(bottom: 3),
          child: Row(
            children: [
              if (title != null) Text(title!),
              Spacer(),
              UIconButton(
                Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
        style: UCardStyle(
          borderRadius: DesignConstants.borderRadiusOnlyTop,
          padding: DesignConstants.paddingMini.copyWith(
            right: DesignConstants.paddingMiniValue,
          ),
          borderColor: Colors.transparent,
        ),
        outline: outline,
        child: Padding(
          padding: EdgeInsets.only(
            right:
                DesignConstants.paddingValue - DesignConstants.paddingMiniValue,
            bottom: context.viewInsets.bottom,
          ),
          child: body,
        ),
      ),
    );
  }
}

class _UDialogWidgetBodyForDesktop extends StatelessWidget {
  const _UDialogWidgetBodyForDesktop({
    Key? key,
    this.title,
    required this.body,
    required this.outline,
  }) : super(key: key);

  final String? title;
  final Widget body;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: DesignConstants.padding,
        padding: EdgeInsets.only(
          top: context.viewInsets.top,
          bottom: context.viewInsets.bottom,
        ),
        constraints: BoxConstraints(
          maxWidth: context.designConstraints.maxPhoneWidth,
        ),
        child: UCard(
          title: Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Row(
              children: [
                if (title != null) Text(title!),
                Spacer(),
                UIconButton(
                  Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
          style: UCardStyle(
            borderRadius: DesignConstants.borderRadius,
            padding: DesignConstants.paddingMini.copyWith(
              right: DesignConstants.paddingMiniValue,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              right: DesignConstants.paddingValue -
                  DesignConstants.paddingMiniValue,
            ),
            child: body,
          ),
        ),
      ),
    );
  }
}
