import 'package:shetter_app/modules/posts/domain/domain.dart';

part 'post_history_event.freezed.dart';

@freezed
class PostHistoryEvent with _$PostHistoryEvent {
  const factory PostHistoryEvent.fetchHistory(Post post, int size) =
      PostHistoryEventFetchHistory;

  const factory PostHistoryEvent.fetchMoreHistory(int size) =
      PostHistoryEventFetchMoreHistory;
}
