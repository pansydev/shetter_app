import 'package:pansy_accounts/infrastructure/infrastructure.dart';

import 'initializer.config.dart';

@injectableInit
void _configureDependencies(GetIt container) => $initGetIt(container);

extension PansyAccountsInitializer on ServiceCollection {
  void configurePansyAccounts() {
    configure(_configureDependencies);
  }
}
