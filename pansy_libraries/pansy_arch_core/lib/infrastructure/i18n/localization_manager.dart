import 'package:pansy_arch_core/infrastructure/i18n/localization_storage.dart';

abstract class LocalizationManager {
  static const fallbackLocale = "en";

  LocalizationStorage get localizationStorage;
}
