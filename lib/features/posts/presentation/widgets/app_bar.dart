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
        child: _UAppBarScaffold(
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

class _UAppBarScaffold extends StatefulWidget {
  const _UAppBarScaffold({
    Key? key,
    required this.value,
    this.onScrollToUp,
  }) : super(key: key);

  final double value;
  final VoidCallback? onScrollToUp;

  @override
  _UAppBarScaffoldState createState() => _UAppBarScaffoldState();
}

class _UAppBarScaffoldState extends State<_UAppBarScaffold>
    with AnimationMixin {
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
    _opacityAnimation = 1.0.tweenTo(-5.5).animatedBy(controller);
    super.initState();
  }

  @override
  void didUpdateWidget(_UAppBarScaffold oldWidget) {
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
      onPressed: isMinimized ? widget.onScrollToUp : null,
      child: AnimatedContainer(
        // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
        duration: 500.milliseconds,
        curve: Curves.fastLinearToSlowEaseIn,
        // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
        width: isMinimized ? 60 : context.width,
        height: isMinimized ? 41 : _maxHeight,
        child: Stack(
          children: [
            FadeTransition(
              opacity: _opacityAnimation,
              child: _UAppBarBody(),
            ),
            Visibility(
              visible: controller.value > 0.19,
              child: AnimatedOpacity(
                opacity: isMinimized ? 1 : 0,
                duration: 300.milliseconds,
                curve: Curves.fastLinearToSlowEaseIn,
                child: Center(
                  child: Icon(
                    Icons.arrow_upward_sharp,
                    // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UAppBarBody extends StatelessWidget {
  const _UAppBarBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      authenticated: (userInfo) => '@${userInfo.username}',
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
