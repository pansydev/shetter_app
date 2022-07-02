import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

extension RegistrationResultMapper on Mutation$Register$register {
  Either<Failure, TokenPair> toEntity() {
    final result = this;

    if (result is Mutation$Register$register$$OperationFailureResult) {
      return Left(OperationFailure(result.code));
    }

    if (result is Mutation$Register$register$$TokenPairOperationSuccessResult) {
      return Right(result.result.toEntity());
    }

    throw Exception('Invalid result state');
  }
}
