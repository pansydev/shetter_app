import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

class ServiceCollection {
  OptionsManagerImpl _optionsManager = OptionsManagerImpl();
  List<Future<void> Function(GetIt container)> _initializers = [];

  Future<ServiceProvider> buildServiceProvider() async {
    var container = GetIt.asNewInstance();

    final serviceProvider = ServiceProvider.fromContainer(container);
    container.registerSingleton<OptionsManager>(_optionsManager);

    for (final initializer in _initializers) {
      await initializer(container);
    }

    await container.allReady();

    return serviceProvider;
  }

  void initializeAsync(Future<void> Function(GetIt container) initializer) {
    _initializers.add(initializer);
  }

  void initialize(void Function(GetIt container) initializer) {
    _initializers.add((x) {
      initializer(x);
      return Future.value();
    });
  }

  void configure<T extends Object>(T options) {
    _optionsManager.add(options);
  }
}
