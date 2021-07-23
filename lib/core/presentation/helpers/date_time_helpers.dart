import 'package:shetter_app/features/posts/presentation/presentation.dart';

extension DateTimeExtensions on DateTime {
  String toFormattedString() {
    final currentLocale = Intl.getCurrentLocale();

    if (isToday || isYesterday || isThisYear) {
      final time = DateFormat("H:mm", currentLocale).format(this);

      if (isToday) {
        return Strings.timeTodayAt.get(time);
      } else if (isYesterday) {
        return Strings.timeYesterdayAt.get(time);
      }

      if (isThisYear) {
        return DateFormat("dd MMMM", currentLocale).format(this) +
            Strings.timeAt.get(time);
      }
    }

    return DateFormat("dd MMMM yyyy", currentLocale).format(this);
  }
}
