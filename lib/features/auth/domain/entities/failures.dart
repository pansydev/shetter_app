import 'package:shetter_app/features/auth/domain/domain.dart';

class AuthenticationFailure extends DomainFailure {
  AuthenticationFailure(String code) : super(code);
}

class RegistrationFailure extends DomainFailure {
  RegistrationFailure(String code) : super(code);
}

class RefreshFailure extends DomainFailure {
  RefreshFailure(String code) : super(code);
}
