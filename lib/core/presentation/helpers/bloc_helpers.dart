import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/core/presentation/presentation.dart';

extension BlocProviderFactory on ServiceProvider {
  BlocProvider<T> createBlocProvider<T extends BlocBase<Object>>() {
    return BlocProvider(create: (_) => resolve<T>());
  }
}
