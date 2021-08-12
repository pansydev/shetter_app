import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shetter_app/app/app.dart';
import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class Application extends StatelessWidget {
  Application(this.serviceProvider) : super(key: Key('Application'));

  final ServiceProvider serviceProvider;

  final AppRouter router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return PansyArchApplication(
      serviceProvider: serviceProvider,
      providers: [
        serviceProvider.createBlocProvider<AuthDialogBloc>(),
        serviceProvider.createBlocProvider<PostListBloc>(),
        serviceProvider.createBlocProvider<PostFormBloc>(),
        serviceProvider.createBlocProvider<AuthBloc>(),
      ],
      child: UDesign(
        constraints: DesignConstants.constraints,
        child: MaterialApp.router(
          routerDelegate: router.delegate(),
          routeInformationParser: router.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          title: PresentationConstants.appName,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ru'),
          ],
          locale: Locale('ru'),
          theme: themeData(),
        ),
      ),
    );
  }
}
