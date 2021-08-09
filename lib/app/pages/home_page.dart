import 'package:shetter_app/core/infrastructure/infrastructure.dart';
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
    // TODO(cirnok): бляяяядь
    context
        .read<ServiceProvider>()
        .resolve<BuildContextAccessor>()
        .buildContext = context;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.designConstraints.maxPhoneWidth,
          ),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: UAppBar(
            onScrollToUp: _scrollController.scrollToUp,
          ),
        ),
        AuthButton(),
        CreatePostFragment(),
        PostListFragment()
      ],
    );
  }
}
