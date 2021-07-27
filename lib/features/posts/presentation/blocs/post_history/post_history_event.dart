import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post_history_event.freezed.dart';

@freezed
class PostHistoryEvent with _$PostHistoryEvent {
  const factory PostHistoryEvent.fetchHistory(Post post) =
      PostHistoryEventFetchHistory;

  const factory PostHistoryEvent.fetchMoreHistory() =
      PostHistoryEventFetchMoreHistory;
}
