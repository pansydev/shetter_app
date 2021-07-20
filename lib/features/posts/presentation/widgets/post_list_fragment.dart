import 'package:shetter_app/features/posts/presentation/presentation.dart';

class PostListFragment extends StatelessWidget {
  const PostListFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: DesignConstants.padding.copyWith(top: 10),
      sliver: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return BlocBuilder<PostListBloc, PostListState>(
            builder: (context, state) {
              return _PostListFragmentPreloader(
                state,
                builder: (connection, [failure]) {
                  return UPostList(
                    connection: connection,
                    authState: authState,
                    failure: failure,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _PostListFragmentPreloader extends StatelessWidget {
  const _PostListFragmentPreloader(
    this.state, {
    Key? key,
    required this.builder,
  }) : super(key: key);

  final PostListState state;
  final PostListBuilder builder;

  @override
  Widget build(BuildContext context) {
    return state.when(
      empty: (failure) => failure != null
          ? UPreloader(failure: failure).sliverBox
          : UPreloader().sliverBox,
      loaded: builder,
      loading: (connection) =>
          connection != null ? builder(connection) : UPreloader().sliverBox,
      loadingMore: builder,
    );
  }
}
