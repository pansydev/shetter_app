import 'package:shetter_app/core/domain/domain.dart';
import 'package:shetter_app/core/presentation/presentation.dart';

abstract class FailureLocalizer {
  static String localize(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return Strings.serverFailureMessage.get();
      case CacheFailure:
        return Strings.cacheFailureMessage.get();
    }

    return Strings.unknownFailure.get();
  }
}
