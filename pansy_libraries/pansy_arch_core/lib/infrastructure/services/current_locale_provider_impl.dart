import 'dart:io';

import 'package:pansy_arch_core/infrastructure/infrastructure.dart';

@Singleton(as: CurrentLocaleProvider)
class CurrentLocaleProviderImpl implements CurrentLocaleProvider {
  @override
  String get currentLocale => Platform.localeName.split('_')[0];
}
