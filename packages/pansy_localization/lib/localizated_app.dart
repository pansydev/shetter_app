import 'pansy_localization.dart';

class PansyLocalizatedApp extends StatefulWidget {
  const PansyLocalizatedApp({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _PansyLocalizatedAppState createState() => _PansyLocalizatedAppState();
}

class _PansyLocalizatedAppState extends State<PansyLocalizatedApp> {
  bool firstLaunch = true;

  @override
  void initState() {
    PansyLocalization.addOnLocaleChangeCallback(_onLocaleChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _onLocaleChange(Locale locale) {
    if (firstLaunch) {
      firstLaunch = false;
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (context as Element).visitChildren(_rebuildElement);
    });
  }

  void _rebuildElement(Element element) {
    element
      ..markNeedsBuild()
      ..visitChildren(_rebuildElement);
  }

  @override
  void dispose() {
    PansyLocalization.removeOnLocaleChangeCallback(_onLocaleChange);
    super.dispose();
  }
}
