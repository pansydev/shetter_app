import 'package:pansy_core/infrastructure/infrastructure.dart';
import 'package:pansy_core/presentation/presentation.dart';

extension PansyCoreLocalizations on CoreLocalizations {
  FailureLocalizer get failureLocalizer =>
      serviceProvider.resolve<FailureLocalizer>();
}
