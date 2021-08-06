import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class PostHistoryDialog extends UDialogWidget {
  PostHistoryDialog(
    this.post, {
    Key? key,
  }) : super(key: key, title: Strings.changesHistory.get(), outline: true);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ServiceProvider>();
    return BlocProvider<PostHistoryBloc>(
      create: (_) => provider.createBloc<PostHistoryBloc>(param1: post),
      child: BlocBuilder<PostHistoryBloc, PostHistoryState>(
        builder: (context, state) {
          return _PostHistoryDialogPreloader(
            state,
            builder: (post, connection, [failure]) {
              return _PostHistoryDialogBody(
                post: post,
                connection: connection,
                failure: failure,
              );
            },
          );
        },
      ),
    );
  }
}

class _PostHistoryDialogBody extends StatelessWidget {
  const _PostHistoryDialogBody({
    Key? key,
    required this.post,
    required this.connection,
    this.failure,
  }) : super(key: key);

  final Post post;
  final Connection<PostVersion> connection;
  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 323,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 5),
        itemBuilder: (_, index) {
          if (index == connection.nodes.length - 1)
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5),
                UPostVersion(
                  connection.nodes[index],
                  author: post.author,
                ),
                UPreloader(
                  visible: connection.pageInfo.hasNextPage,
                  failure: failure,
                ),
              ],
            );

          if (index == 0)
            return UPostVersion(
              connection.nodes[index],
              author: post.author,
            );

          return Column(
            children: [
              SizedBox(height: 5),
              UPostVersion(
                connection.nodes[index],
                author: post.author,
              ),
            ],
          );
        },
        itemCount: connection.nodes.length,
      ),
    );
  }
}

class _PostHistoryDialogPreloader extends StatelessWidget {
  const _PostHistoryDialogPreloader(
    this.state, {
    Key? key,
    required this.builder,
  }) : super(key: key);

  final PostHistoryState state;
  final PostHistoryBuilder builder;

  @override
  Widget build(BuildContext context) {
    return state.when(
      empty: (_, failure) =>
          failure != null ? UPreloader(failure: failure) : UPreloader(),
      loaded: builder,
      loading: (post, connection) =>
          connection != null ? builder(post, connection) : UPreloader(),
      loadingMore: builder,
    );
  }
}
