import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shetter_app/app/app.dart';
import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/modules/posts/presentation/presentation.dart';

class Application extends StatelessWidget {
  Application({super.key});

  final AppRouter _router = AppRouter();
  final _supportedLocales = const [
    Locale('en'),
    Locale('ru'),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        AuthDialogBlocProvider(),
        PostHistoryBlocProvider(),
        PostListBlocProvider(),
        PostFormBlocProvider(),
        AuthBlocProvider(),
      ],
      child: UDesign(
        constraints: DesignConstants.constraints,
        child: MaterialApp.router(
          routerDelegate: _router.delegate(),
          routeInformationParser: _router.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          title: PresentationConstants.appName,
          localizationsDelegates: [
            PansyLocalizationDelegate(_supportedLocales),
            PansyUILocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: _supportedLocales,
          locale: const Locale('ru'),
          theme: themeData(),
        ),
      ),
    );
  }
}
