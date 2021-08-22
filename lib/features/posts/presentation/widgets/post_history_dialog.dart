import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class PostHistoryDialog extends StatelessWidget {
  const PostHistoryDialog(
    this.post, {
    Key? key,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ServiceProvider>();
    return BlocProvider<PostHistoryBloc>(
      create: (_) => provider.createBloc<PostHistoryBloc>(param1: post),
      child: PostHistoryDialogWithBloc(),
    );
  }
}

class PostHistoryDialogWithBloc extends StatefulWidget {
  const PostHistoryDialogWithBloc({Key? key}) : super(key: key);

  @override
  _PostHistoryDialogWithBlocState createState() =>
      _PostHistoryDialogWithBlocState();
}

class _PostHistoryDialogWithBlocState extends State<PostHistoryDialogWithBloc> {
  late UPaginate _paginate;

  @override
  void initState() {
    super.initState();
    _paginate = UPaginate(
      minChildHeight: PostHistoryBloc.minChildHeight,
      onFetchRequest: onFetchRequest,
    );
  }

  void onFetchRequest(int size) {
    context.read<PostHistoryBloc>().fetchMore(size);
  }

  @override
  void dispose() {
    _paginate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostHistoryBloc, PostHistoryState>(
      builder: (context, state) {
        return UDialog(
          title: localizations.shetter.change_history,
          child: USliverConstructor(
            controller: _paginate.controller,
            shrinkWrap: false,
            children: [
              _PostHistoryDialogPreloader(
                state,
                builder: (post, connection, [failure]) {
                  return _PostHistoryDialogBody(
                    post: post,
                    connection: connection,
                    failure: failure,
                  );
                },
              ),
            ],
          ),
        );
      },
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
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          if (index == connection.nodes.length - 1) {
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
                  onTryAgain: () =>
                      context.read<PostHistoryBloc>().retry(context),
                ),
              ],
            );
          }

          if (index == 0) {
            return UPostVersion(
              connection.nodes[index],
              author: post.author,
            );
          }

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
        childCount: connection.nodes.length,
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
      empty: (_, failure) => failure != null
          ? UPreloader(
              failure: failure,
              onTryAgain: () => onTryAgain(context),
            ).sliverBox
          : UPreloader().sliverBox,
      loaded: builder,
      loading: (post, connection) => connection != null
          ? builder(post, connection)
          : UPreloader().sliverBox,
      loadingMore: builder,
    );
  }

  void onTryAgain(context) => context.read<PostHistoryBloc>().retry(context);
}
