import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

extension AuthenticationResultMapper on Mutation$Auth$auth {
  Either<Failure, TokenPair> toEntity() {
    final result = this;

    if (result is Mutation$Auth$auth$$OperationFailureResult) {
      return Left(OperationFailure(result.code));
    }

    if (result is Mutation$Auth$auth$$TokenPairOperationSuccessResult) {
      return Right(result.result.toEntity());
    }

    throw Exception('Invalid result state');
  }
}
