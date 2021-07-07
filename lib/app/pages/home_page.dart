import 'package:shetter_app/features/auth/presentation/presentation.dart';
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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: DesignConstants.maxWindowWidth),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PostListBloc, PostListState>(
      builder: (context, state) => CustomScrollView(
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
          BlocBuilder<AppBarBloc, AppBarState>(
            builder: (context, state) => state.when(
              authenticated: (_) => Container(),
              unauthenticated: () => AuthFragment(),
            ),
          ).sliverBox,
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
