import 'dart:io';

import 'package:pansy_ui/pansy_ui.dart';

class PansyLocalizationManager {
  final locales = {
    'en': Pansy(),
    'ru': PansyRu(),
  };

  Pansy get pansy => locales[Platform.localeName] ?? locales['en']!;
}

final localizations = PansyLocalizationManager();
