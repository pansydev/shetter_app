import 'package:shetter_app/core/presentation/presentation.dart';

part 'frame_loader.freezed.dart';

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
      ignoring: state is UFrameLoaderStateLoading,
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: state is UFrameLoaderStateInitial ? 1 : 0.5,
            duration: duration,
            child: UAnimatedScale(
              scale: state is UFrameLoaderStateInitial ? 1 : 0.95,
              duration: duration,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

@freezed
class UFrameLoaderState with _$UFrameLoaderState {
  const factory UFrameLoaderState.initial() = UFrameLoaderStateInitial;
  const factory UFrameLoaderState.loading() = UFrameLoaderStateLoading;
}
