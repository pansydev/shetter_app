import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

extension PansyArchCoreServiceCollectionExtensions on ServiceCollection {
  Future<ServiceScope> buildRootScopeWithConfigurations() async {
    addSingleton<OptionsManagerImpl>();

    return buildRootScope();
  }

  Iterable<Object> _getServices(Type type) sync* {
    for (final descriptor in this) {
      if (descriptor.serviceType == type) {
        yield descriptor.serviceType;
      }
    }
  }

  Object? _getService(Type serviceType) {
    for (final element in _getServices(serviceType)) {
      return element;
    }

    return null;
  }

  TService? get<TService>() {
    return _getService(TService) as TService?;
  }

  TService getRequired<TService>() {
    final service = get<TService>();

    if (service == null) {
      throw Exception("No service registered for type $TService");
    }

    return service;
  }

  void configure<T extends Object>(T options) {
    getRequired<OptionsManager>().add(options);
  }
}
