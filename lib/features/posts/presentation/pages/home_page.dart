import 'package:shetter_app/features/posts/presentation/presentation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter <= 500) {
        context.read<PostListBloc>().fetchMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostListBloc, PostListState>(
        builder: _buildBody,
      ),
    );
  }

  Widget _buildBody(BuildContext context, PostListState state) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: DesignConstants.maxWindowWidth),
        child: CustomScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: UAppBar(
                onScrollToUp: _scrollController.scrollToUp,
              ),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: context.read<PostListBloc>().refresh,
            ),
            SliverPadding(
              padding: DesignConstants.padding.copyWith(top: 10),
              sliver: _buildPreloader(
                state,
                builder: (connection, [failure]) {
                  return UPostList(
                    connection: connection,
                    failure: failure,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreloader(
    PostListState state, {
    required PostListBuilder builder,
  }) {
    return state.when(
      empty: (failure) => failure != null
          ? Preloader(failure: failure).sliverBox
          : Preloader().sliverBox,
      loaded: (connection, failure) => builder(connection, failure),
      loading: (connection) =>
          connection != null ? builder(connection) : Preloader().sliverBox,
      loadingMore: (connection) => builder(connection),
    );
  }
}
