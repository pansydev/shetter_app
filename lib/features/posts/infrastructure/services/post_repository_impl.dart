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
  Future<Either<Failure, PostLikes>> likePost(
    String postId,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    return Right(
      PostLikes(isLiked: true, count: 10),
    );
  }

  @override
  Future<Either<Failure, PostLikes>> dislikePost(
    String postId,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    return Right(
      PostLikes(isLiked: false, count: 9),
    );
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

    final query = _client.watchQueryPosts(options);

    return mapObservableQuery(
      query,
      (event) => event.parsedDataQueryPosts!.posts!.toEntity(),
      (exception) => log(
        'An error occurred while fetching the post list',
        name: '$this',
        error: exception,
      ),
    );
  }

  @override
  Stream<Either<Failure, Post>> subscribeToNewPosts() {
    final options = SubscriptionOptions(
      document: SUBSCRIPTION_POST_CREATED,
    );

    final stream = _client.subscribe(options);

    return mapResultStream(
      stream,
      (event) {
        // TODO(exeteres): Update cache rather than clear
        _client.cache.store.reset();

        final result = SubscriptionPostCreated.fromJson(event.data!);
        return result.postCreated.toEntity();
      },
      (exception) => log(
        'An error occurred while obtaining the created post',
        name: '$this',
        error: exception,
      ),
    );
  }

  @override
  Stream<Either<Failure, Post>> subscribeToEditedPosts() {
    final options = SubscriptionOptions(
      document: SUBSCRIPTION_POST_EDITED,
    );

    final stream = _client.subscribe(options);

    return mapResultStream(
      stream,
      (event) {
        // TODO(exeteres): Update cache rather than clear
        _client.cache.store.reset();

        final result = SubscriptionPostEdited.fromJson(event.data!);
        return result.postEdited.toEntity();
      },
      (exception) => log(
        'An error occurred while obtaining the edited post',
        name: '$this',
        error: exception,
      ),
    );
  }

  @override
  Stream<Either<Failure, Connection<PostVersion>>> getPostPreviousVersions(
    String postId, {
    required int pageSize,
    String? after,
  }) {
    final options = GQLWatchOptionsQueryPostPreviousVersions(
      fetchResults: true,
      variables: VariablesQueryPostPreviousVersions(
        postId: postId,
        after: after,
        pageSize: pageSize,
      ),
      fetchPolicy: _fetchPolicyProvider.fetchPolicy,
    );

    final query = _client.watchQueryPostPreviousVersions(options);

    return mapObservableQuery(
      query,
      (event) {
        final post = event.parsedDataQueryPostPreviousVersions!.post;

        if (post == null) {
          // TODO(exeteres): handle 404
          throw Exception('Post not found');
        }

        return post.previousVersions!.toEntity();
      },
      (exception) => log(
        'An error occurred while fetching the post change history',
        name: '$this',
        error: exception,
      ),
    );
  }
}
