import 'package:shetter_app/core/presentation/presentation.dart';

extension DateTimeExtensions on DateTime {
  String toFormattedString() {
    final currentLocale = Intl.getCurrentLocale();

    if (isToday || isYesterday || isThisYear) {
      final time = DateFormat('H:mm', currentLocale).format(this);

      if (isToday) {
        return localizations.shetter.time_today_at(time);
      }

      if (isYesterday) {
        return localizations.shetter.time_yesterday_at(time);
      }

      if (isThisYear) {
        return DateFormat('dd MMMM', currentLocale).format(this) +
            localizations.shetter.time_at(time);
      }
    }

    return DateFormat('dd MMMM yyyy', currentLocale).format(this);
  }
}
