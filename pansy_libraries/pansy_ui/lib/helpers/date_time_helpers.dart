extension UDateTimeExtensions on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  bool get isYesterday {
    final now = DateTime.now().subtract(Duration(days: 1));
    return day == now.day && month == now.month && year == now.year;
  }

  bool get isThisYear => year == DateTime.now().year;
}
