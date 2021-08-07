import 'package:pansy_accounts/infrastructure/infrastructure.dart';
import 'package:pansy_accounts/presentation/presentation.dart';

import 'initializer.config.dart';

@injectableInit
Future<void> _configureDependencies(GetIt container) => $initGetIt(container);

extension PansyAccountsInitializer on ServiceCollection {
  void configurePansyAccounts({required EnumSessionAudience audience}) {
    configurePansyCore();

    addAsyncInitializer(_configureDependencies);

    configure(PansyAccountsOptions(audience));

    configureI18N({
      "en": LocaleDescriptor(Accounts(), accountsMap),
      "ru": LocaleDescriptor(AccountsRu(), accountsRuMap),
    });
  }
}
