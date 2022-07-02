import 'package:pansy_accounts/infrastructure/infrastructure.dart';
import 'package:pansy_accounts/presentation/presentation.dart';

extension PansyAccountsInitializer on ServiceCollection {
  Future<void> configurePansyAccounts(
      {required Enum$SessionAudience audience}) async {
    configurePansyCore();

    addSingleton<HiveBoxFactory>();
    addSingletonFactory(HiveBoxFactory.create);

    addSingleton<TokenManagerImpl>();
    addSingleton<AuthenticationStateManagerImpl>();
    addSingleton<RefreshManagerImpl>();
    addSingleton<AuthBloc>();
    addSingleton<AuthLinkFactoryImpl>();
    addSingleton<GraphQLClient>();
    addSingleton<AuthRepositoryImpl>();
    addSingleton<AuthManagerImpl>();

    addSingleton<AuthDialogBloc>();

    configure(PansyAccountsOptions(audience));

    configureI18N({
      'en': LocaleDescriptor(Accounts(), accountsMap),
      'ru': LocaleDescriptor(AccountsRu(), accountsRuMap),
    });
  }
}
