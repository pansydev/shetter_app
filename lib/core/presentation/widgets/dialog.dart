import 'package:shetter_app/core/presentation/presentation.dart';

abstract class UDialogWidget extends StatelessWidget {
  const UDialogWidget({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  Future<T?> show<T>(BuildContext context) {
    if (!context.isDesktop) {
      return showCupertinoModalPopup<T>(
        context: context,
        barrierColor: Colors.black45,
        builder: (context) => _UDialogWidgetBodyForPhone(
          title: title,
          body: this,
        ),
      );
    } else {
      return showCupertinoDialog<T>(
        context: context,
        barrierDismissible: true,
        builder: (context) => _UDialogWidgetBodyForDesktop(
          title: title,
          body: this,
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
  }) : super(key: key);

  final String? title;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
      constraints: BoxConstraints(maxWidth: DesignConstants.maxWindowWidth),
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
        ),
        child: Padding(
          padding: EdgeInsets.only(
            right:
                DesignConstants.paddingValue - DesignConstants.paddingMiniValue,
            bottom: MediaQuery.of(context).viewInsets.bottom,
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
  }) : super(key: key);

  final String? title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: DesignConstants.padding,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewInsets.top,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        constraints: BoxConstraints(maxWidth: DesignConstants.maxWindowWidth),
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
