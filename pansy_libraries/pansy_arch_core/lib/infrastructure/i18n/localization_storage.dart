import 'dart:collection';

typedef LocalizationMap = UnmodifiableMapView<String, String>;

abstract class LocalizationStorage {
  LocalizationMap get localizationMap;

  T getLocalization<T extends Object>();
}
