import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class UPostList extends StatelessWidget {
  const UPostList({
    Key? key,
    required this.connection,
    required this.authState,
    this.failure,
  }) : super(key: key);

  final Connection<Post> connection;
  final AuthState authState;
  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          if (index == connection.nodes.length - 1)
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UPost(
                  connection.nodes[index],
                  authState: authState,
                ),
                UPreloader(
                  visible: connection.pageInfo.hasNextPage,
                  failure: failure,
                ),
              ],
            );

          return Column(
            children: [
              UPost(
                connection.nodes[index],
                authState: authState,
              ),
              SizedBox(height: 10),
            ],
          );
        },
        childCount: connection.nodes.length,
      ),
    );
  }
}
