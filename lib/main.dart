import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/core/presentation/presentation.dart';
import 'package:shetter_app/app/app.dart';

import 'package:pansy_accounts/infrastructure/infrastructure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final services = ServiceCollection()
    ..configureGraphQL()
    ..configurePansyAccounts(audience: EnumSessionAudience.shetter)
    ..configureShetter();

  final provider = await services.buildServiceProvider();

  runApp(Provider.value(
    value: provider,
    child: Application(),
  ));
}
