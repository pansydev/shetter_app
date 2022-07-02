import 'package:shetter_app/modules/posts/domain/domain.dart';

part 'post_history_state.freezed.dart';

@freezed
class PostHistoryState with _$PostHistoryState {
  const factory PostHistoryState.empty({
    required Post post,
    Failure? failure,
  }) = PostHistoryStateEmpty;

  const factory PostHistoryState.loaded({
    required Post post,
    required Connection<PostVersion> connection,
    Failure? failure,
  }) = PostHistoryStateLoaded;

  const factory PostHistoryState.loading({
    required Post post,
    Connection<PostVersion>? connection,
  }) = PostHistoryStateLoading;

  const factory PostHistoryState.loadingMore({
    required Post post,
    required Connection<PostVersion> connection,
  }) = PostHistoryStateLoadingMore;
}
