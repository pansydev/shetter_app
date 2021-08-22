import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class UPostList extends StatelessWidget {
  const UPostList({
    Key? key,
    required this.connection,
    this.failure,
  }) : super(key: key);

  final Connection<Post> connection;
  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          if (index == connection.nodes.length - 1) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UPost(connection.nodes[index]),
                UPreloader(
                  visible: connection.pageInfo.hasNextPage,
                  failure: failure,
                  onTryAgain: () => context.read<PostListBloc>().retry(context),
                ),
              ],
            );
          }

          return Column(
            children: [
              UPost(connection.nodes[index]),
              SizedBox(height: 10),
            ],
          );
        },
        childCount: connection.nodes.length,
      ),
    );
  }
}
