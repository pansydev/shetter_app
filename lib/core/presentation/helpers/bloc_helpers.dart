import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/core/presentation/presentation.dart';

extension BlocFactory on ServiceProvider {
  T createBloc<T extends BlocBase<Object>>({
    param1,
    param2,
  }) {
    return resolve<T>(param1: param1, param2: param2);
  }

  BlocProvider<T> createBlocProvider<T extends BlocBase<Object>>({
    param1,
    param2,
  }) {
    return BlocProvider(
      create: (_) => createBloc<T>(param1: param1, param2: param2),
    );
  }
}
