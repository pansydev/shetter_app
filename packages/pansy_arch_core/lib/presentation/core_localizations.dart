import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

late CoreLocalizations localizations;

void setupGlobalLocalization(ServiceProvider serviceProvider) {
  localizations = serviceProvider.getRequired<CoreLocalizations>();
}

class CoreLocalizations {
  CoreLocalizations(this._localizationManager, this.serviceProvider);

  final LocalizationManager _localizationManager;
  final ServiceProvider serviceProvider;

  T get<T extends Object>() {
    return _localizationManager.localizationStorage.getLocalization<T>();
  }
}
