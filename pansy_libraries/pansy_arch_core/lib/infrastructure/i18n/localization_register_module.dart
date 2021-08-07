import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

@module
abstract class LocalizationRegisterModule {
  LocalizationManager getLocalizationManager(ServiceProvider serviceProvider) =>
      serviceProvider.resolve<LocalizationManagerImpl>();
}
