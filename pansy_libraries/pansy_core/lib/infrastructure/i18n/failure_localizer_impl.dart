import 'package:pansy_core/domain/domain.dart';
import 'package:pansy_core/domain/entities/server_failure.dart';
import 'package:pansy_core/infrastructure/infrastructure.dart';
import 'package:pansy_core/presentation/presentation.dart';

@Singleton(as: FailureLocalizer)
class FailureLocalizerImpl implements FailureLocalizer {
  FailureLocalizerImpl(this._localizationManager);

  final LocalizationManager _localizationManager;

  Core get _localization =>
      _localizationManager.localizationStorage.getLocalization<Core>();

  @override
  String localizeCode(String code) {
    final localizationStorage = _localizationManager.localizationStorage;
    final localizationKey = "failures.${code.replaceAll(':', '_')}";

    return localizationStorage.localizationMap[localizationKey] ??
        _localization.unknown_failure;
  }

  @override
  String localize(Failure failure) {
    if (failure is OperationFailure) {
      return localizeCode(failure.code);
    }

    if (failure is ServerFailure) {
      return _localization.server_failure_message;
    }

    if (failure is CacheFailure) {
      return _localization.cache_failure_message;
    }

    return _localization.unknown_failure;
  }
}
