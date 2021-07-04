import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/infrastructure/infrastructure.dart';

extension RefreshResultMapper on MutationRefresh$refresh {
  Either<Failure, TokenPair> toEntity() {
    final result = this;

    if (result is MutationRefresh$refresh$RefreshFailureResult) {
      return Left(AuthenticationFailure(result.code));
    }

    if (result is MutationRefresh$refresh$RefreshSuccessResult) {
      return Right(result.tokens.toEntity());
    }

    throw Exception("Invalid result state");
  }
}
