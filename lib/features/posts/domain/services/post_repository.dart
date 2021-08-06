import 'package:shetter_app/features/posts/domain/domain.dart';

abstract class PostRepository {
  Stream<Either<Failure, Connection<Post>>> getPosts({
    required int pageSize,
    String? after,
  });

  Future<Option<Failure>> createPost(CreatePostInput input);
  Future<Option<Failure>> editPost(String postId, EditPostInput input);

  Stream<Either<Failure, Post>> subsribeToPosts();

  Stream<Either<Failure, Connection<PostVersion>>> getPostPreviousVersions(
    String postId, {
    required int pageSize,
    String? after,
  });
}
