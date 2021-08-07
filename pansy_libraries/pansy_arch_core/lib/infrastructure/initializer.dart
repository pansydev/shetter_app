import 'package:pansy_arch_core/infrastructure/infrastructure.dart';
import 'package:pansy_arch_core/presentation/presentation.dart';

import 'initializer.config.dart';

@injectableInit
void _configureDependencies(GetIt container) => $initGetIt(container);

void _initializeBuildContext(GetIt container) {
  container.registerFactory<BuildContext>(
      () => container.get<BuildContextAccessor>().buildContext);
}

extension PansyArchCoreInitializer on ServiceCollection {
  void configurePansyArchCore() {
    addInitializer(_configureDependencies);
    addInitializer(_initializeBuildContext);
  }
}
