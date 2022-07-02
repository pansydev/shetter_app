import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/presentation/presentation.dart';

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
            // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
            const SizedBox(height: 15),
            UButton(
              onPressed: onTryAgain!,
              child: Text(localizations.shetter.try_again_action),
            ),
          ],
        ],
      );
    } else if (visible) {
      child = const CupertinoActivityIndicator();
    } else {
      return const SizedBox();
    }

    return Center(
      child: Padding(
        // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
        padding: const EdgeInsets.all(35).copyWith(top: 45),
        child: child,
      ),
    );
  }
}
