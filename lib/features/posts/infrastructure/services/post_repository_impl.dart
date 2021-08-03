import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._client, this._fetchPolicyProvider);

  final GraphQLClient _client;
  final FetchPolicyProvider _fetchPolicyProvider;

  @override
  Future<Either<Failure, Post>> createPost(PostInput input) async {
    final options = GQLOptionsMutationCreatePost(
      variables: VariablesMutationCreatePost(
        input: PostInputMapper.postInputToDto(input),
      ),
    );

    final result = await _client.mutateCreatePost(options);

    if (result.hasException) {
      log('${result.exception}', name: '$this');
      return Left(ServerFailure());
    }

    return result.parsedDataMutationCreatePost!.createPost.toEntity();
  }

  @override
  Stream<Either<Failure, Connection<Post>>> getPosts({
    required int pageSize,
    String? after,
  }) {
    final options = GQLWatchOptionsQueryPosts(
      fetchResults: true,
      variables: VariablesQueryPosts(pageSize: pageSize, after: after),
      fetchPolicy: _fetchPolicyProvider.fetchPolicy,
    );

    final result = _client.watchQueryPosts(options);

    return result.stream.map((event) {
      if (event.hasException) {
        log('${event.exception}', name: '$this');
        if (event.exception!.linkException is CacheMissException) {
          return Left(CacheFailure());
        }

        return Left(ServerFailure());
      }

      return Right(event.parsedDataQueryPosts!.posts!.toEntity());
    });
  }

  @override
  Stream<Either<Failure, Post>> subsribeToPosts() {
    final options = SubscriptionOptions(
      document: SUBSCRIPTION_POST_CREATED,
    );

    final stream = _client.subscribe(options);

    return stream.map((event) {
      if (event.hasException) {
        log('${event.exception}', name: '$this');
        return Left(ServerFailure());
      }

      final result = SubscriptionPostCreated.fromJson(event.data!);

      return Right(result.postCreated.toEntity());
    });
  }

  @override
  Stream<Either<Failure, Connection<PostVersion>>> getPostPreviousVersions(
    String postId, {
    required int pageSize,
    String? after,
  }) {
    final options = GQLWatchOptionsQueryPostPreviousVersions(
      fetchResults: true,
      variables: VariablesQueryPostPreviousVersions(postId: postId),
      fetchPolicy: _fetchPolicyProvider.fetchPolicy,
    );

    final result = _client.watchQueryPostPreviousVersions(options);

    return result.stream.map((event) {
      if (event.hasException) {
        log('${event.exception}', name: '$this');
        if (event.exception!.linkException is CacheMissException) {
          return Left(CacheFailure());
        }

        if (event.parsedDataQueryPostPreviousVersions?.post == null) {
          // TODO handle 404
          return Left(ServerFailure());
        }

        return Left(ServerFailure());
      }

      final connection = event
          .parsedDataQueryPostPreviousVersions!.post!.previousVersions!
          .toEntity();

      return Right(connection);
    });
  }
}
