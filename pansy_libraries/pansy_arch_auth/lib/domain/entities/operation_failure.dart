import 'package:pansy_arch_auth/domain/domain.dart';

class OperationFailure extends Failure {
  OperationFailure(this.code);

  String code;
}
