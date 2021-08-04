import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension AuthenticationResultMapper on FragmentPostOperationResult {
  Either<Failure, Post> toEntity() {
    final result = this;

    if (result is FragmentPostOperationResult$OperationFailureResult) {
      return Left(OperationFailure(result.code));
    }

    if (result is FragmentPostOperationResult$PostOperationSuccessResult) {
      return Right(result.result.toEntity());
    }

    throw Exception("Invalid result state");
  }
}
