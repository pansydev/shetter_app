import 'package:shetter_app/features/posts/domain/domain.dart';

abstract class PostRepository {
  Stream<Either<Failure, Connection<Post>>> getPosts({
    required int pageSize,
    String? after,
  });

  Future<Either<Failure, Post>> createPost(CreatePostInput input);
  Future<Either<Failure, Post>> editPost(String postId, EditPostInput input);

  Stream<Either<Failure, Post>> subsribeToPosts();

  Stream<Either<Failure, Connection<PostVersion>>> getPostPreviousVersions(
    String postId, {
    required int pageSize,
    String? after,
  });
}
