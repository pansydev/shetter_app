import 'package:shetter_app/core/presentation/presentation.dart';

const Duration _animationDuration = Duration(milliseconds: 300);
const Curve _animationCurve = Curves.linearToEaseOut;

class UAnimatedVisibility extends StatefulWidget {
  const UAnimatedVisibility({
    Key? key,
    required this.child,
    required this.visible,
    this.lazySize = true,
  }) : super(key: key);

  final Widget child;
  final bool visible;
  final bool lazySize;

  @override
  _UAnimatedVisibilityState createState() => _UAnimatedVisibilityState();
}

class _UAnimatedVisibilityState extends State<UAnimatedVisibility>
    with TickerProviderStateMixin {
  bool _visible = false;
  bool _close = false;
  bool _closeInProcessing = false;

  @override
  void initState() {
    super.initState();
    _visible = widget.visible;
    _close = !widget.visible;
  }

  @override
  void didUpdateWidget(UAnimatedVisibility oldWidget) {
    super.didUpdateWidget(oldWidget);
    final duration = widget.lazySize ? 200.milliseconds : Duration.zero;

    if (widget.visible != _visible) {
      setState(() => _closeInProcessing = false);

      if (widget.visible) {
        setState(() {
          _close = false;
          _closeInProcessing = true;
        });

        if (_closeInProcessing == true) {
          Future.delayed(duration).then((_) {
            setState(() => _visible = true);
          });
        } else {
          setState(() => _visible = true);
        }
      } else {
        setState(() {
          _visible = false;
          _closeInProcessing = true;
        });

        Future.delayed(duration).then((_) {
          if (_closeInProcessing == true) {
            setState(() => _close = true);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      duration: _animationDuration,
      curve: _animationCurve,
      child: SizedBox(
        width: _close ? 0 : null,
        height: _close ? 0 : null,
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: _animationDuration,
          curve: _animationCurve,
          child: UAnimatedScale(
            scale: _visible ? 1 : 0.8,
            duration: _animationDuration,
            curve: _animationCurve,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
