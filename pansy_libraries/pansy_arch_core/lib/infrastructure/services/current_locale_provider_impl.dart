import 'dart:io';

import 'package:pansy_arch_core/infrastructure/infrastructure.dart';
import 'package:pansy_arch_core/presentation/presentation.dart';

@Singleton(as: CurrentLocaleProvider)
class CurrentLocaleProviderImpl implements CurrentLocaleProvider {
  @override
  String get currentLocale => PansyLocalization.instance.locale.languageCode;
}
