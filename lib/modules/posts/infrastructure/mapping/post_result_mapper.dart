import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/infrastructure/infrastructure.dart';

extension PostResultMapper on Fragment$PostOperationResult {
  Option<Failure> toEntity() {
    final result = this;

    if (result is Fragment$PostOperationResult$$OperationFailureResult) {
      return Some(OperationFailure(result.code));
    }

    return const None();
  }
}
