import 'package:pansy_arch_core/domain/domain.dart';

class OperationFailure extends Failure {
  OperationFailure(this.code);
  final String code;
}
