abstract class Failure {}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class DomainFailure extends Failure {
  DomainFailure(this.code);

  final String code;
}
