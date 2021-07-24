import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

class ServiceProvider {
  ServiceProvider.fromContainer(this._container) {
    _container.registerSingleton(this);
  }

  final GetIt _container;

  T resolve<T extends Object>() {
    return _container.get<T>();
  }
}
