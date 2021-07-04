import 'dart:developer' as developer;

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
      return Left(ServerFailure());
    }

    return Right(result.parsedDataMutationCreatePost!.createPost.toEntity());
  }

  @override
  Future<Either<Failure, Connection<Post>>> getPosts({
    required int pageSize,
    String? after,
  }) async {
    final options = GQLOptionsQueryPosts(
      variables: VariablesQueryPosts(pageSize: pageSize, after: after),
      fetchPolicy: _fetchPolicyProvider.fetchPolicy,
    );

    final result = await _client.queryPosts(options);

    if (result.hasException) {
      developer.log("Post fetching failed", error: result.exception);

      if (result.exception!.linkException is CacheMissException) {
        return Left(CacheFailure());
      }

      return Left(ServerFailure());
    }

    return Right(result.parsedDataQueryPosts!.posts!.toEntity());
  }

  @override
  Stream<Either<Failure, Post>> subsribeToPosts() {
    final options = SubscriptionOptions(
      document: SUBSCRIPTION_POST_CREATED,
    );

    final stream = _client.subscribe(options);

    return stream.map((event) {
      if (event.hasException) {
        return Left(ServerFailure());
      }
      final result = SubscriptionPostCreated.fromJson(event.data!);

      return Right(result.postCreated.toEntity());
    });
  }
}
