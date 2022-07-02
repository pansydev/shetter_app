import 'pansy_localization.dart';

typedef LocaleUpdateCallback = void Function(Locale locale);

class PansyLocalization {
  PansyLocalization._();

  final List<LocaleUpdateCallback> _onLocaleUpdateCallbacks = [];
  late Locale locale;

  static final PansyLocalization _instance = PansyLocalization._();
  static PansyLocalization get instance => _instance;

  static void updateLocale(Locale locale) {
    instance.locale = locale;
    for (final element in instance._onLocaleUpdateCallbacks) {
      element.call(locale);
    }
  }

  static void addOnLocaleChangeCallback(LocaleUpdateCallback onChange) {
    instance._onLocaleUpdateCallbacks.add(onChange);
  }

  static void removeOnLocaleChangeCallback(LocaleUpdateCallback onChange) {
    instance._onLocaleUpdateCallbacks.remove(onChange);
  }

  static PansyLocalization? maybeOf(BuildContext context) =>
      Localizations.of<PansyLocalization>(
        context,
        PansyLocalization,
      );

  static PansyLocalization of(BuildContext context) {
    final localizations = PansyLocalization.maybeOf(context);
    if (localizations == null) {
      throw FlutterError.fromParts([
        ErrorSummary('No PansyLocalization found.'),
        ErrorDescription(
            '${context.widget.runtimeType} widgets require PansyLocalization '
            'to be provided by a Localizations widget ancestor.'),
        ErrorHint(
            'Did you forget to add PansyLocalization localization delegate to '
            'MaterialApp widget?'),
        ...context.describeMissingAncestor(
          expectedAncestorType: PansyLocalization,
        )
      ]);
    }
    return localizations;
  }
}
