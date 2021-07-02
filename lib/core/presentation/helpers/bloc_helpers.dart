import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/core/presentation/presentation.dart';

Stream<T> Function() keep<T>(T state) {
  return () async* {
    yield state;
  };
}

extension BlocProviderFactory on ServiceProvider {
  BlocProvider<T> createBlocProvider<T extends BlocBase<Object>>() {
    return BlocProvider(create: (_) => resolve<T>());
  }
}
