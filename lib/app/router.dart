import 'package:auto_route/auto_route.dart';
import 'package:shetter_app/app/app.dart';

export 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
  ],
)
class $AppRouter {}
