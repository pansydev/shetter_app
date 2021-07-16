import 'package:shetter_app/core/presentation/presentation.dart';

abstract class UDialogWidget extends StatelessWidget {
  const UDialogWidget({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  Widget body(BuildContext context);

  @protected
  @override
  Widget build(BuildContext context) {
    return _UDialogWidgetBodyForPhone(
      title: title,
      body: body(context),
    );
  }

  Future<T?> show<T>(BuildContext context) {
    return showCupertinoModalPopup<T>(
      context: context,
      barrierColor: Colors.black45,
      builder: (context) => this,
    );
  }
}

class _UDialogWidgetBodyForPhone extends StatelessWidget {
  const _UDialogWidgetBodyForPhone({
    this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  final String? title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return UCard(
      title: Row(
        children: [
          if (title != null) Text(title!),
          Spacer(),
          UIconButton(
            Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      style: UCardStyle(
        borderRadius: DesignConstants.borderRadiusOnlyTop,
        padding: DesignConstants.paddingMini.copyWith(
          right: DesignConstants.paddingMiniValue,
          bottom: DesignConstants.paddingMiniValue +
              context.mediaQueryViewPadding.bottom,
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
    );
  }
}
