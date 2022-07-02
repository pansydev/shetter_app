import 'package:pansy_arch_graphql/infrastructure/infrastructure.dart';

extension GraphQLInitializer on ServiceCollection {
  void configureGraphQL() {
    addSingleton<NetworkManagerImpl>();
    addSingleton<FetchPolicyProviderImpl>();
  }
}
