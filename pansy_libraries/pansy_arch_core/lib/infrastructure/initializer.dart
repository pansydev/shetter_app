import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

import 'initializer.config.dart';

@injectableInit
void _configureDependencies(GetIt container) => $initGetIt(container);

extension PansyArchCoreInitializer on ServiceCollection {
  void configurePansyArchCore() {
    addInitializer(_configureDependencies);
  }
}
