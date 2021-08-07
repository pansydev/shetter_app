import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

class LocalizationStorageImpl implements LocalizationStorage {
  final List<Object> _localizationInstances = [];
  final Map<String, String> _localizationMap = {};

  void addLocalization(Object instance, Map<String, String> map) {
    _localizationInstances.add(instance);
    _localizationMap.addAll(map);
  }

  @override
  T getLocalization<T extends Object>() {
    return _localizationInstances.firstWhere((x) => x is T) as T;
  }

  @override
  LocalizationMap get localizationMap => _localizationMap as LocalizationMap;
}
