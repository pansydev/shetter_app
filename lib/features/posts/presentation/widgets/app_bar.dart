import 'package:shetter_app/features/posts/presentation/presentation.dart';

final maxHeight = (Get.statusBarHeight / Get.pixelRatio) + 87.0;
final minHeight = (Get.statusBarHeight / Get.pixelRatio) + 60.0;

class UAppBar extends SliverPersistentHeaderDelegate {
  const UAppBar({
    this.title,
    this.actions,
    this.onScrollToUp,
  });

  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onScrollToUp;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final offset = shrinkOffset / maxHeight;

    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: _UAppBarBody(
          value: offset,
          onScrollToUp: onScrollToUp,
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _UAppBarBody extends StatefulWidget {
  const _UAppBarBody({
    Key? key,
    required this.value,
    this.onScrollToUp,
  }) : super(key: key);

  final double value;
  final VoidCallback? onScrollToUp;

  @override
  _UAppBarBodyState createState() => _UAppBarBodyState();
}

class _UAppBarBodyState extends State<_UAppBarBody> with AnimationMixin {
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _opacityAnimation = 1.0.tweenTo(-5.5).animatedBy(controller);
    super.initState();
  }

  @override
  void didUpdateWidget(_UAppBarBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final isMinimized = controller.value > 0.2;

    return UCard.outline(
      style: UCardStyle(
        margin: DesignConstants.padding.copyWith(bottom: 0),
        padding: EdgeInsets.zero,
      ),
      clipBehavior: Clip.antiAlias,
      onPressed: isMinimized ? widget.onScrollToUp : null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        width: isMinimized ? 60 : context.width,
        height: isMinimized ? 41 : maxHeight,
        child: Stack(
          children: [
            FadeTransition(
              opacity: _opacityAnimation,
              child: _buildBody(context),
            ),
            Visibility(
              visible: controller.value > 0.19,
              child: AnimatedOpacity(
                opacity: isMinimized ? 1 : 0,
                duration: Duration(milliseconds: 300),
                curve: Curves.fastLinearToSlowEaseIn,
                child: _buildBackButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Center(
      child: Icon(
        Icons.arrow_upward_sharp,
        size: 20,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: DesignConstants.paddingAlt.copyWith(bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.homePageTitle.get(),
                style: context.textTheme.headline6,
              ),
              SizedBox(height: 2),
              BlocBuilder<AppBarBloc, AppBarState>(
                builder: (context, state) => Text(
                  state.when(
                    authenticated: (userInfo) => "@${userInfo.username}",
                    unauthenticated: () => Strings.unauthenticated.get(),
                  ),
                  style: context.textTheme.subtitle2?.copyWith(
                    fontSize: 13,
                    color: context.textTheme.subtitle2?.color?.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          BlocBuilder<AppBarBloc, AppBarState>(
            builder: (context, state) => state.when(
              authenticated: (userInfo) => UIconButton(
                Icon(
                  Icons.exit_to_app,
                  size: 22,
                ),
                style: UIconButtonStyle(margin: EdgeInsets.zero),
                onPressed: context.read<AppBarBloc>().logout,
              ),
              unauthenticated: () => Container(),
            ),
          ),
        ],
      ),
    );
  }
}
