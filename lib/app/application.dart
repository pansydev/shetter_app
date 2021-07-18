import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shetter_app/app/app.dart';

import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/core/presentation/presentation.dart';

import 'package:shetter_app/features/auth/presentation/presentation.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class Application extends StatelessWidget {
  Application(
    this.router,
    this.provider,
  ) : super(key: Key("Application"));

  final AppRouter router;
  final ServiceProvider provider;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        provider.createBlocProvider<AuthFragmentBloc>(),
        provider.createBlocProvider<PostListBloc>(),
        provider.createBlocProvider<PostFormBloc>(),
        provider.createBlocProvider<AuthBloc>()
      ],
      child: MaterialApp.router(
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
        theme: darkThemeData,
      ),
    );
  }
}
