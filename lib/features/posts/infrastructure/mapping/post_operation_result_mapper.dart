import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostOperationResultMapper on FragmentPostOperationResult {
  Option<Failure> toEntity() {
    final result = this;

    if (result is FragmentPostOperationResult$OperationFailureResult) {
      return Some(OperationFailure(result.code));
    }

    return None();
  }
}
