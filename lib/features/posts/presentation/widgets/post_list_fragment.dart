import 'package:shetter_app/features/posts/presentation/presentation.dart';

class PostListFragment extends StatelessWidget {
  const PostListFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: DesignConstants.padding.copyWith(top: 10),
      sliver: BlocBuilder<PostListBloc, PostListState>(
        builder: (context, state) {
          return _buildPreloader(
            state,
            builder: (connection, [failure]) {
              return UPostList(
                connection: connection,
                failure: failure,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPreloader(
    PostListState state, {
    required PostListBuilder builder,
  }) {
    return state.when(
      empty: (failure) => failure != null
          ? UPreloader(failure: failure).sliverBox
          : UPreloader().sliverBox,
      loaded: (connection, failure) => builder(connection, failure),
      loading: (connection) =>
          connection != null ? builder(connection) : UPreloader().sliverBox,
      loadingMore: (connection) => builder(connection),
    );
  }
}
