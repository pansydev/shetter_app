import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension OperationResultMapper on FragmentOperationResult {
  Option<Failure> toEntity() {
    final result = this;

    if (result is FragmentOperationResult$OperationFailureResult) {
      return Some(OperationFailure(result.code));
    }

    return None();
  }
}
