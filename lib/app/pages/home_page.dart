import 'package:shetter_app/features/posts/presentation/presentation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UPaginate _paginate;

  @override
  void initState() {
    super.initState();
    _paginate = UPaginate(
      minChildHeight: PostListBloc.minChildHeight,
      onFetchRequest: onFetchRequest,
    );
  }

  void onFetchRequest(int size) {
    context.read<PostListBloc>().fetchMore(size);
  }

  @override
  void dispose() {
    _paginate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.designConstraints.maxPhoneWidth,
          ),
          child: CustomScrollView(
            controller: _paginate.controller,
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: UAppBar(
                  onScrollToUp: _paginate.controller.scrollToUp,
                ),
              ),
              AuthButton(),
              CreatePostFragment(),
              PostListFragment(),
            ],
          ),
        ),
      ),
    );
  }
}
