import 'package:shetter_app/core/domain/domain.dart';

class CacheFailure extends Failure {}

class DomainFailure extends Failure {
  DomainFailure(this.code);

  final String code;
}
