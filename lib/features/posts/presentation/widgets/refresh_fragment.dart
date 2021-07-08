import 'package:shetter_app/features/posts/presentation/presentation.dart';

class RefreshFragment extends StatelessWidget {
  const RefreshFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: context.read<PostListBloc>().refresh,
    );
  }
}
