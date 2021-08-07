import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

class LocaleDescriptor<T> {
  LocaleDescriptor(this.instance, this.map);

  final T instance;
  final Map<String, String> map;
}

extension I18NInitializer on ServiceCollection {
  void configureI18N<T extends Object>(
    Map<String, LocaleDescriptor<T>> locales,
  ) {
    if (!locales.containsKey(LocalizationManager.fallbackLocale)) {
      throw Exception(
        "Fallback locale $LocalizationManager.fallbackLocale is not provided",
      );
    }

    addInitializer((container) {
      final localizationManager = container.get<LocalizationManagerImpl>();

      for (final locale in locales.entries) {
        localizationManager.getLocalizationStorage(locale.key)
          ..addLocalization(
            locale.value.instance,
            locale.value.map,
          );
      }
    });
  }
}
