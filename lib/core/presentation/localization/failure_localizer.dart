import 'package:shetter_app/core/domain/domain.dart';
import 'package:shetter_app/core/presentation/presentation.dart';

abstract class FailureLocalizer {
  static String localize(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return Strings.serverFailureMessage.get();
      case CacheFailure:
        return Strings.cacheFailureMessage.get();
      case DomainFailure:
        return _localizeDomainFailure(failure as DomainFailure);
    }

    return Strings.unknownFailure.get();
  }

  static String _localizeDomainFailure(DomainFailure failure) {
    switch (failure.code) {
      case "Authentication:InvalidCredentials":
        return Strings.authenticationInvalidCredentials.get();
      case "Refresh:InvalidRefreshToken":
        return Strings.refreshInvalidRefreshToken.get();
      case "Registration:UserAlreadyExists":
        return Strings.registrationUserAlreadyExists.get();
    }

    return Strings.unknownFailure.get();
  }
}
