import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

class ServiceCollection {
  List<Future<void> Function(GetIt container)> _initializers = [];

  Future<ServiceProvider> buildServiceProvider() async {
    var container = GetIt.asNewInstance();

    for (final initializer in _initializers) {
      await initializer(container);
    }

    await container.allReady();

    return ServiceProvider.fromContainer(container);
  }

  void configureAsync(Future<void> Function(GetIt container) initializer) {
    _initializers.add(initializer);
  }

  void configure(void Function(GetIt container) initializer) {
    _initializers.add((x) => Future.value(x));
  }
}
