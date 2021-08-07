import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/core/presentation/presentation.dart';

import 'initializer.config.dart';

@injectableInit
Future<void> _configureDependencies(GetIt container) => $initGetIt(container);

extension ShetterInitializer on ServiceCollection {
  void configureShetter() {
    addAsyncInitializer(_configureDependencies);

    configureI18N({
      "en": LocaleDescriptor(Shetter(), shetterMap),
      "ru": LocaleDescriptor(ShetterRu(), shetterRuMap),
    });
  }
}
