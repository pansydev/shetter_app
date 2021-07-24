import 'package:pansy_arch_auth/domain/domain.dart';

class CacheFailure extends Failure {}

class DomainFailure extends Failure {
  DomainFailure(this.code);

  final String code;
}
