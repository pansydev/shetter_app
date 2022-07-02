import 'package:pansy_ui/pansy_ui.dart';

class PansyUILocalizations {
  PansyUILocalizations(this.locale);
  final Locale locale;

  static PansyUILocalizations of(BuildContext context) {
    final result =
        Localizations.of<PansyUILocalizations>(context, PansyUILocalizations);
    assert(result != null, 'No PansyUILocalizations found in context');
    return result!;
  }

  static const LocalizationsDelegate<PansyUILocalizations> delegate =
      _LocalizationDelegate();

  static const supportLocales = {
    'en': Pansy(),
    'ru': PansyRu(),
  };

  Pansy get localizations => supportLocales[locale.languageCode]!;
}

class _LocalizationDelegate
    extends LocalizationsDelegate<PansyUILocalizations> {
  const _LocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return PansyUILocalizations.supportLocales.keys
        .contains(locale.languageCode);
  }

  @override
  Future<PansyUILocalizations> load(Locale locale) async {
    return PansyUILocalizations(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<PansyUILocalizations> old) => false;
}
