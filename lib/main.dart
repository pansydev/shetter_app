import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/core/presentation/presentation.dart';
import 'package:shetter_app/app/app.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

import 'main.dino.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final rootScope = await createServiceScope();
  setupGlobalLocalization(rootScope.serviceProvider);

  runApp(
    Provider(
      create: (_) => rootScope.serviceProvider,
      child: Application(),
    ),
  );
}

Future<ServiceScope> createServiceScope() async {
  final services = $ServiceCollection()
    ..configureGraphQL()
    ..configurePansyAccounts(audience: Enum$SessionAudience.SHETTER)
    ..configureShetter();

  final rootScope = services.buildRootScope();
  await rootScope.initialize();

  return rootScope;
}
