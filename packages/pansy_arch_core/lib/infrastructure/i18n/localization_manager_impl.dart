import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

class LocalizationManagerImpl implements LocalizationManager {
  LocalizationManagerImpl(this._currentLocaleProvider);

  final Map<String, LocalizationStorage> _localizationManagers = {};

  final CurrentLocaleProvider _currentLocaleProvider;

  LocalizationStorageImpl getLocalizationStorage(String locale) {
    if (_localizationManagers[locale] == null) {
      _localizationManagers[locale] = LocalizationStorageImpl();
    }

    return _localizationManagers[locale]! as LocalizationStorageImpl;
  }

  @override
  LocalizationStorage get localizationStorage =>
      _localizationManagers[_currentLocaleProvider.currentLocale] ??
      _localizationManagers[LocalizationManager.fallbackLocale]!;
}
