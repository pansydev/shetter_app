import 'package:timeago/timeago.dart' as timeago;

abstract class PostsPresentationLayer {
  static void ensureInitialized() {
    timeago.setLocaleMessages('en', timeago.EnMessages());
    timeago.setLocaleMessages('ru', timeago.RuMessages());
  }
}
