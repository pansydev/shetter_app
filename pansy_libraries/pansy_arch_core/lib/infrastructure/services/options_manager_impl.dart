import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

class OptionsManagerImpl implements OptionsManager {
  final Map<Type, Object> _optionMap = {};

  void add<T extends Object>(T options) {
    _optionMap[T] = options;
  }

  @override
  T get<T extends Object>() {
    return _optionMap[T]! as T;
  }
}
