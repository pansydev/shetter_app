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
    final result = await _client.mutateCreatePost(
      GQLOptionsMutationCreatePost(
        variables: VariablesMutationCreatePost(
          input: PostInputMapper.postInputToDto(input),
        ),
      ),
    );

    if (result.hasException) {
      return Left(ServerFailure());
    }

    return Right(result.parsedDataMutationCreatePost!.createPost.toEntity());
  }

  @override
  Stream<Either<Failure, Connection<Post>>> getPosts({
    required int pageSize,
    String? after,
  }) {
    final result = _client.watchQueryPosts(
      GQLWatchOptionsQueryPosts(
        fetchResults: true,
        variables: VariablesQueryPosts(pageSize: pageSize, after: after),
        fetchPolicy: _fetchPolicyProvider.fetchPolicy,
      ),
    );

    return result.stream.map((event) {
      if (event.hasException) {
        developer.log("Post fetching failed", error: event.exception);

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
    final stream = _client.subscribe(
      SubscriptionOptions(document: SUBSCRIPTION_POST_CREATED),
    );

    return stream.map((event) {
      if (event.hasException) {
        return Left(ServerFailure());
      }
      final result = SubscriptionPostCreated.fromJson(event.data!);

      return Right(result.postCreated.toEntity());
    });
  }
}
