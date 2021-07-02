abstract class DateTimeMapper {
  static DateTime unixSecondsToDateTime(int seconds) {
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }
}
