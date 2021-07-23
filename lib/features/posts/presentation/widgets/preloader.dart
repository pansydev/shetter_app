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
        padding: EdgeInsets.all(35).copyWith(top: 45),
        child: child,
      ),
    );
  }

  Widget _buildFailureMessage(BuildContext context) {
    return Column(
      children: [
        Text(
          FailureLocalizer.localize(failure!),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        UButton(
          onPressed: context.read<PostListBloc>().retry,
          child: Text(Strings.tryAgainAction.get()),
        ),
      ],
    );
  }
}
