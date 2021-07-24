import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

extension RegistrationResultMapper on MutationRegister$register {
  Either<Failure, TokenPair> toEntity() {
    final result = this;

    if (result is MutationRegister$register$OperationFailureResult) {
      return Left(OperationFailure(result.code));
    }

    if (result is MutationRegister$register$TokenPairOperationSuccessResult) {
      return Right(result.result.toEntity());
    }

    throw Exception("Invalid result state");
  }
}
