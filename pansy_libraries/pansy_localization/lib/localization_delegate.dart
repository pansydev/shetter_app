import 'pansy_localization.dart';

class PansyLocalizationDelegate
    extends LocalizationsDelegate<PansyLocalization> {
  const PansyLocalizationDelegate(this.supportedLocales);
  final List<Locale> supportedLocales;

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<PansyLocalization> load(Locale locale) {
    PansyLocalization.updateLocale(locale);
    return Future.value(PansyLocalization.instance);
  }

  @override
  bool shouldReload(LocalizationsDelegate<PansyLocalization> old) => false;
}
