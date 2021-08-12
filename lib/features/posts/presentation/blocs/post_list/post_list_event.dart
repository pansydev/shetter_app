import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post_list_event.freezed.dart';

@freezed
class PostListEvent with _$PostListEvent {
  const factory PostListEvent.fetchPosts() = PostListEventFetchPosts;
  const factory PostListEvent.fetchMorePosts() = PostListEventFetchMorePosts;

  const factory PostListEvent.postCreated(Either<Failure, Post> post) =
      PostListEventPostCreated;

  const factory PostListEvent.postEdited(Either<Failure, Post> post) =
      PostListEventPostEdited;
}
