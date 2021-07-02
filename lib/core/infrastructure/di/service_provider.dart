import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_provider.config.dart';

@injectableInit
void _configureDependencies(GetIt container) => $initGetIt(container);

class ServiceProvider {
  ServiceProvider._() {
    _configureDependencies(_container);
  }

  final GetIt _container = GetIt.asNewInstance();

  T resolve<T extends Object>() {
    return _container.get<T>();
  }

  static Future<ServiceProvider> create() async {
    final provider = ServiceProvider._();
    await provider._container.allReady();
    return provider;
  }
}
