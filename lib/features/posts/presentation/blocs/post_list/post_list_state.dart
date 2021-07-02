import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post_list_state.freezed.dart';

@freezed
class PostListState with _$PostListState {
  const factory PostListState.empty({
    Failure? failure,
  }) = PostListStateEmpty;

  const factory PostListState.loaded({
    required Connection<Post> connection,
    Failure? failure,
  }) = PostListStateLoaded;

  const factory PostListState.loading({
    Connection<Post>? connection,
  }) = PostListStateLoading;

  const factory PostListState.loadingMore({
    required Connection<Post> connection,
  }) = PostListStateLoadingMore;
}
