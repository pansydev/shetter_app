import 'dart:ui' show window;

import 'package:shetter_app/features/posts/presentation/presentation.dart';

final _statusBarHeight = window.padding.top / window.devicePixelRatio;
final _maxHeight = _statusBarHeight + 89.0;
final _minHeight = _statusBarHeight + 60.0;

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
    final offset = shrinkOffset / _maxHeight;

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
  double get maxExtent => _maxHeight;

  @override
  double get minExtent => _minHeight;

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
        duration: 500.milliseconds,
        curve: Curves.fastLinearToSlowEaseIn,
        width: isMinimized ? 60 : context.width,
        height: isMinimized ? 41 : _maxHeight,
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
                duration: 300.milliseconds,
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
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.shetter.home_page_title,
                    style: context.textTheme.headline6,
                  ),
                  SizedBox(height: 2),
                  Text(
                    state.when(
                      authenticated: (userInfo) => "@${userInfo.username}",
                      unauthenticated: () =>
                          localizations.shetter.unauthenticated,
                    ),
                    style: context.textTheme.subtitle2?.copyWith(
                      fontSize: 13,
                      color:
                          context.textTheme.subtitle2?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Spacer(),
              UAnimatedVisibility(
                visible: state is AuthStateAuthenticated,
                child: UIconButton(
                  Icon(
                    Icons.exit_to_app,
                    size: 22,
                  ),
                  style: UIconButtonStyle(padding: DesignConstants.padding5),
                  tooltip: localizations.shetter.logout,
                  onPressed: context.read<AuthBloc>().logout,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
