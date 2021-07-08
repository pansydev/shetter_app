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
      child: _buildMaterialApp(context),
      providers: [
        provider.createBlocProvider<AuthBloc>(),
        provider.createBlocProvider<PostListBloc>(),
        provider.createBlocProvider<AppBarBloc>()
      ],
    );
  }

  MaterialApp _buildMaterialApp(BuildContext context) {
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
