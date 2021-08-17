import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._client, this._fetchPolicyProvider);

  final GraphQLClient _client;
  final FetchPolicyProvider _fetchPolicyProvider;

  @override
  Future<Option<Failure>> createPost(CreatePostInput input) async {
    final options = GQLOptionsMutationCreatePost(
      variables: VariablesMutationCreatePost(
        text: input.text,
        images: await Future.wait(input.images
            .map((e) => MultipartFile.fromPath('', e.path))
            .toList()),
      ),
    );

    final result = await _client.mutateCreatePost(options);

    if (result.hasException) {
      log('An error occurred while creating the post',
          name: '$this', error: result.exception);

      return Some(ServerFailure());
    }

    return result.parsedDataMutationCreatePost!.createPost.toEntity();
  }

  @override
  Future<Option<Failure>> editPost(
    String postId,
    EditPostInput input,
  ) async {
    final options = GQLOptionsMutationEditPost(
      variables: VariablesMutationEditPost(
        postId: postId,
        input: PostInputMapper.mapEditPostInputToDto(input),
      ),
    );

    final result = await _client.mutateEditPost(options);

    if (result.hasException) {
      log('An error occurred while editing the post',
          name: '$this', error: result.exception);

      return Some(ServerFailure());
    }

    return result.parsedDataMutationEditPost!.editPost.toEntity();
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

    return result.stream.where((event) => event.data != null).map((event) {
      if (event.hasException) {
        log('An error occurred while fetching the post list',
            name: '$this', error: event.exception);

        if (event.exception!.linkException is CacheMissException) {
          return Left(CacheFailure());
        }

        return Left(ServerFailure());
      }

      return Right(event.parsedDataQueryPosts!.posts!.toEntity());
    });
  }

  @override
  Stream<Either<Failure, Post>> subscribeToNewPosts() {
    final options = SubscriptionOptions(
      document: SUBSCRIPTION_POST_CREATED,
    );

    final stream = _client.subscribe(options);

    return stream.map((event) {
      if (event.hasException) {
        log('An error occurred while obtaining the created post',
            name: '$this', error: event.exception);

        return Left(ServerFailure());
      }

      final result = SubscriptionPostCreated.fromJson(event.data!);

      return Right(result.postCreated.toEntity());
    });
  }

  @override
  Stream<Either<Failure, Post>> subscribeToEditedPosts() {
    final options = SubscriptionOptions(
      document: SUBSCRIPTION_POST_EDITED,
    );

    final stream = _client.subscribe(options);

    return stream.map((event) {
      if (event.hasException) {
        log('An error occurred while obtaining the edited post',
            name: '$this', error: event.exception);

        return Left(ServerFailure());
      }

      final result = SubscriptionPostEdited.fromJson(event.data!);

      return Right(result.postEdited.toEntity());
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
        log('An error occurred while fetching the post change history',
            name: '$this', error: event.exception);

        if (event.exception!.linkException is CacheMissException) {
          return Left(CacheFailure());
        }

        if (event.parsedDataQueryPostPreviousVersions?.post == null) {
          // TODO(exeteres): handle 404
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
