import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

typedef SyncInitializer = void Function(GetIt container);
typedef AsyncInitializer = Future<void> Function(GetIt container);

class ServiceCollection {
  final OptionsManagerImpl _optionsManager = OptionsManagerImpl();
  final List<dynamic> _initializers = [];

  Future<ServiceProvider> buildServiceProvider() async {
    var container = GetIt.asNewInstance();

    final serviceProvider = ServiceProvider.fromContainer(container);
    container.registerSingleton<OptionsManager>(_optionsManager);

    for (final initializer in _initializers) {
      if (initializer is AsyncInitializer) {
        await initializer(container);
        continue;
      }

      if (initializer is SyncInitializer) {
        initializer(container);
        continue;
      }
    }

    await container.allReady();

    return serviceProvider;
  }

  void addAsyncInitializer(Future<void> Function(GetIt container) initializer) {
    addInitializer(initializer);
  }

  void addInitializer(void Function(GetIt container) initializer) {
    if (!_initializers.contains(initializer)) {
      _initializers.add(initializer);
    }
  }

  void configure<T extends Object>(T options) {
    _optionsManager.add(options);
  }
}
