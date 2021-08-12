import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class UPreloader extends StatelessWidget {
  const UPreloader({
    Key? key,
    this.visible = true,
    this.failure,
  }) : super(key: key);

  final bool visible;
  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (failure != null) {
      child = _buildFailureMessage(context);
    } else if (this.visible) {
      child = CupertinoActivityIndicator();
    } else {
      return SizedBox();
    }

    return Center(
      child: Padding(
        // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
        padding: EdgeInsets.all(35).copyWith(top: 45),
        child: child,
      ),
    );
  }

  // TODO(cirnok): Get rid of widget on functions, https://github.com/pansydev/shetter_app/issues/7
  Widget _buildFailureMessage(BuildContext context) {
    return Column(
      children: [
        Text(
          localizations.failureLocalizer.localize(failure!),
          textAlign: TextAlign.center,
        ),
        // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
        SizedBox(height: 15),
        UButton(
          onPressed: context.read<PostListBloc>().retry,
          child: Text(localizations.shetter.try_again_action),
        ),
      ],
    );
  }
}
