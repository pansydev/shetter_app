import 'package:pansy_arch_core/infrastructure/infrastructure.dart';
import 'package:pansy_arch_core/presentation/presentation.dart';

@Singleton(as: CurrentLocaleProvider)
class CurrentLocaleProviderImpl implements CurrentLocaleProvider {
  CurrentLocaleProviderImpl(this._buildContextAccessor);

  final BuildContextAccessor _buildContextAccessor;

  @override
  String get currentLocale =>
      Localizations.localeOf(_buildContextAccessor.buildContext).languageCode;
}
