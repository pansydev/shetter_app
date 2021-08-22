import 'package:pansy_core/infrastructure/infrastructure.dart';
import 'package:pansy_core/presentation/presentation.dart';

import 'initializer.config.dart';

@injectableInit
void _configureDependencies(GetIt container) => $initGetIt(container);

extension PansyCoreInitializer on ServiceCollection {
  void configurePansyCore() {
    configurePansyArchCore();

    addInitializer(_configureDependencies);

    configureI18N({
      'en': LocaleDescriptor(Core(), coreMap),
      'ru': LocaleDescriptor(CoreRu(), coreRuMap),
    });
  }
}
