import 'package:shetter_app/core/presentation/presentation.dart';

extension DateTimeExtensions on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  bool get isYesterday {
    final now = DateTime.now() - 1.days;
    return day == now.day && month == now.month && year == now.year;
  }

  bool get isThisYear => year == DateTime.now().year;

  String toFormatedString() {
    if (isToday || isYesterday || isThisYear) {
      final time = DateFormat("H:mm", Get.locale?.languageCode).format(this);

      if (isToday) {
        return Strings.timeTodayAt.get(time);
      } else if (isYesterday) {
        return Strings.timeYesterdayAt.get(time);
      }

      if (isThisYear) {
        return DateFormat("dd MMMM", Get.locale?.languageCode).format(this) +
            Strings.timeAt.get(time);
      }
    }

    return DateFormat("dd MMMM yyyy", Get.locale?.languageCode).format(this);
  }
}
