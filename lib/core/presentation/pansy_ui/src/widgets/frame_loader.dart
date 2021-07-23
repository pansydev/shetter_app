import '../../pansy_ui.dart';

enum UFrameLoaderState { initial, loading }

class UFrameLoader extends StatelessWidget {
  const UFrameLoader({
    Key? key,
    required this.child,
    required this.state,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 100),
  }) : super(key: key);

  final Widget child;
  final UFrameLoaderState state;
  final Curve curve;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: state == UFrameLoaderState.loading,
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: state == UFrameLoaderState.initial ? 1 : 0.5,
            duration: duration,
            child: UAnimatedScale(
              scale: state == UFrameLoaderState.initial ? 1 : 0.95,
              duration: duration,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
