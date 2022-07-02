import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

abstract class LocalizationRegisterModule {
  LocalizationManager getLocalizationManager(ServiceProvider serviceProvider) =>
      serviceProvider.getRequired<LocalizationManagerImpl>();
}
