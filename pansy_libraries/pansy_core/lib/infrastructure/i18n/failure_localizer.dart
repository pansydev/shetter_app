import 'package:pansy_core/domain/domain.dart';

abstract class FailureLocalizer {
  String localize(Failure failure);
  String localizeCode(String code);
}
