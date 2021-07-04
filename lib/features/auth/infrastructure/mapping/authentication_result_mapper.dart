import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/infrastructure/infrastructure.dart';

extension AuthenticationResultMapper on MutationAuth$auth {
  Either<Failure, TokenPair> toEntity() {
    final result = this;

    if (result is MutationAuth$auth$AuthenticationFailureResult) {
      return Left(AuthenticationFailure(result.code));
    }

    if (result is MutationAuth$auth$AuthenticationSuccessResult) {
      return Right(result.tokens.toEntity());
    }

    throw Exception("Invalid result state");
  }
}
