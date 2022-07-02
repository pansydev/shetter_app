typedef LocalizationMap = Map<String, String>;

abstract class LocalizationStorage {
  LocalizationMap get localizationMap;

  T getLocalization<T extends Object>();
}
