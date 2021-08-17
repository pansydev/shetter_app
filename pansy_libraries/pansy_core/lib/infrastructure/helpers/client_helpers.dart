import 'package:pansy_core/domain/domain.dart';
import 'package:pansy_core/infrastructure/exports.dart';

void unawaited(Future future) {}

Stream<Either<Failure, T>> mapObservableQuery<T extends Object>(
  ObservableQuery query,
  T Function(QueryResult) resultTransformer, [
  void Function(OperationException)? onException,
]) async* {
  await for (final queryResult in query.stream) {
    if (queryResult.data == null) continue;

    if (queryResult.hasException) {
      onException?.call(queryResult.exception!);

      final exception = queryResult.exception!.linkException!.originalException;

      if (exception is PartialDataException && !queryResult.isLoading) {
        log('Rerunning query because of partial data');

        unawaited(query.refetch());
        continue;
      }
    }

    try {
      yield mapResult(queryResult, resultTransformer);
    } on Exception {
      yield Left(ServerFailure());
    }
  }
}

Stream<Either<Failure, T>> mapResultStream<T extends Object>(
  Stream<QueryResult> resultStream,
  T Function(QueryResult) resultTransformer, [
  void Function(OperationException)? onException,
]) {
  return resultStream.map(
    (event) => mapResult(
      event,
      resultTransformer,
      onException,
    ),
  );
}

Either<Failure, T> mapResult<T>(
  QueryResult queryResult,
  T Function(QueryResult) resultTransformer, [
  void Function(OperationException)? onException,
]) {
  if (queryResult.hasException) {
    onException?.call(queryResult.exception!);

    if (queryResult.exception!.linkException is CacheMissException) {
      return Left(CacheFailure());
    }

    return Left(ServerFailure());
  }

  return Right(resultTransformer(queryResult));
}
