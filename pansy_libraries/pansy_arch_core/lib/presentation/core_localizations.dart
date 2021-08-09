import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

late CoreLocalizations localizations;

void setupGlobalLocalization(ServiceProvider serviceProvider) {
  localizations = serviceProvider.resolve<CoreLocalizations>();
}

@singleton
class CoreLocalizations {
  CoreLocalizations(this._localizationManager, this.serviceProvider);

  final LocalizationManager _localizationManager;
  final ServiceProvider serviceProvider;

  T resolve<T extends Object>() {
    return _localizationManager.localizationStorage.getLocalization<T>();
  }
}
