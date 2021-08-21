import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shetter_app/app/app.dart';
import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class Application extends StatelessWidget {
  Application(this._serviceProvider) : super(key: Key('Application'));

  final ServiceProvider _serviceProvider;

  final AppRouter _router = AppRouter();
  final _supportedLocales = const [
    Locale('en'),
    Locale('ru'),
  ];

  @override
  Widget build(BuildContext context) {
    return PansyArchApplication(
      serviceProvider: _serviceProvider,
      providers: [
        _serviceProvider.createBlocProvider<AuthDialogBloc>(),
        _serviceProvider.createBlocProvider<PostListBloc>(),
        _serviceProvider.createBlocProvider<PostFormBloc>(),
        _serviceProvider.createBlocProvider<AuthBloc>(),
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
          locale: Locale('ru'),
          theme: themeData(),
        ),
      ),
    );
  }
}
