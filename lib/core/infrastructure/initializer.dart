import 'package:shetter_app/core/infrastructure/infrastructure.dart';

import 'initializer.config.dart';

@injectableInit
Future<void> _configureDependencies(GetIt container) => $initGetIt(container);

extension ShetterInitializer on ServiceCollection {
  void configureShetter() {
    initializeAsync(_configureDependencies);
  }
}
