import 'package:shetter_app/features/posts/domain/domain.dart';

abstract class PostRepository {
  Stream<Either<Failure, Connection<Post>>> getPosts({
    required int pageSize,
    String? after,
  });

  Future<Either<Failure, Post>> createPost(PostInput input);
  Stream<Either<Failure, Post>> subsribeToPosts();

  Future<Either<Failure, UnmodifiableListView<PostVersion>>>
      getPostPreviousVersions(String postId);
}
