import 'package:pansy_arch_graphql/infrastructure/infrastructure.dart';

import 'initializer.config.dart';

@injectableInit
void _configureDependencies(GetIt container) => $initGetIt(container);

extension GraphQLInitializer on ServiceCollection {
  void configureGraphQL() {
    addInitializer(_configureDependencies);
  }
}
