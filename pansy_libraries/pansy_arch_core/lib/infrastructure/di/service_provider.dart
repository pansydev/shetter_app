import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

class ServiceProvider {
  ServiceProvider.fromContainer(this._container) {
    _container.registerSingleton(this);
  }

  final GetIt _container;

  T resolve<T extends Object>({String? name, param1, param2}) {
    return _container.get<T>(
      instanceName: name,
      param1: param1,
      param2: param2,
    );
  }
}
