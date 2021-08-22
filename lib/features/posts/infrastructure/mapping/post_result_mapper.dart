import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostResultMapper on FragmentPostOperationResult {
  Option<Failure> toEntity() {
    final result = this;

    if (result is FragmentPostOperationResult$OperationFailureResult) {
      return Some(OperationFailure(result.code));
    }

    if (result is FragmentPostOperationResult) {
      return None();
    }

    throw Exception('Invalid result state');
  }
}
