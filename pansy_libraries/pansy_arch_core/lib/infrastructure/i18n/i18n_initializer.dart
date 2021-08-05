import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

extension I18NInitializer on ServiceCollection {
  static const fallbackLocale = "en";

  void configureI18N<T extends Object>(Map<String, T> locales) {
    if (!locales.containsKey(fallbackLocale)) {
      throw Exception("Fallback locale $fallbackLocale is not provided");
    }

    initialize((container) {
      container.registerFactoryParam((param1, _) {
        return locales[param1] ?? locales[fallbackLocale]!;
      });
    });
  }
}
