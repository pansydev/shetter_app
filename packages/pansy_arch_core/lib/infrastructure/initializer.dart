import 'package:pansy_arch_core/infrastructure/infrastructure.dart';
import 'package:pansy_arch_core/presentation/presentation.dart';

extension PansyArchCoreInitializer on ServiceCollection {
  void configurePansyArchCore() {
    addSingleton<CurrentLocaleProviderImpl>();
    addSingleton<LocalizationManagerImpl>();
    addSingleton<CoreLocalizations>();
  }
}
