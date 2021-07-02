import 'package:auto_localized/annotations.dart';

@AutoLocalized(
  locales: [
    AutoLocalizedLocale(
      languageCode: "en",
      translationsFilePath: "assets/locales/en.json",
    ),
    AutoLocalizedLocale(
      languageCode: "ru",
      translationsFilePath: "assets/locales/ru.json",
    ),
  ],
)
class $Strings {}
