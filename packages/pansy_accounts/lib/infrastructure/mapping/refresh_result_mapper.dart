import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

extension RefreshResultMapper on Mutation$Refresh$refresh {
  Either<Failure, TokenPair> toEntity() {
    final result = this;

    if (result is Mutation$Refresh$refresh$$OperationFailureResult) {
      return Left(OperationFailure(result.code));
    }

    if (result is Mutation$Refresh$refresh$$TokenPairOperationSuccessResult) {
      return Right(result.result.toEntity());
    }

    throw Exception('Invalid result state');
  }
}
