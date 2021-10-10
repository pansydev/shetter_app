import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class UPreloader extends StatelessWidget {
  const UPreloader({
    Key? key,
    this.visible = true,
    this.failure,
    this.onTryAgain,
  }) : super(key: key);

  final bool visible;
  final Failure? failure;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (failure != null) {
      child = Column(
        children: [
          Text(
            localizations.failureLocalizer.localize(failure!),
            textAlign: TextAlign.center,
          ),
          if (onTryAgain != null) ...[
            SizedBox(height: 15),
            UButton(
              onPressed: onTryAgain!,
              child: Text(localizations.shetter.try_again_action),
            ),
          ],
        ],
      );
    } else if (this.visible) {
      child = CupertinoActivityIndicator();
    } else {
      return SizedBox();
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.all(35).copyWith(top: 45),
        child: child,
      ),
    );
  }
}
