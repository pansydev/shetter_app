import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shetter_app/core/presentation/presentation.dart';
import 'package:shetter_app/router.dart';

class Application extends StatelessWidget {
  Application(this.router) : super(key: Key("Application"));
  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      title: PresentationConstants.appName,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        ...context.localizationsDelegates,
      ],
      locale: Locale('ru'),
      theme: lightThemeData,
      darkTheme: darkThemeData,
    );
  }
}
