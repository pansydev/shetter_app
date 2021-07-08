import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/infrastructure/infrastructure.dart';

extension RegistrationResultMapper on MutationRegister$register {
  Either<Failure, TokenPair> toEntity() {
    final result = this;

    if (result is MutationRegister$register$RegistrationFailureResult) {
      return Left(AuthenticationFailure(result.code));
    }

    if (result is MutationRegister$register$RegistrationSuccessResult) {
      return Right(result.tokens.toEntity());
    }

    throw Exception("Invalid result state");
  }
}
