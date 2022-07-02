import 'package:pansy_core/infrastructure/infrastructure.dart';
import 'package:pansy_core/presentation/presentation.dart';

extension PansyCoreInitializer on ServiceCollection {
  void configurePansyCore() {
    addSingleton<FailureLocalizerImpl>();

    configureI18N({
      'en': LocaleDescriptor(Core(), coreMap),
      'ru': LocaleDescriptor(CoreRu(), coreRuMap),
    });
  }
}
