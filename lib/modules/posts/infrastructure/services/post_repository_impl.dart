import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/infrastructure/infrastructure.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._client, this._fetchPolicyProvider);

  final GraphQLClient _client;
  final FetchPolicyProvider _fetchPolicyProvider;

  @override
  Future<Option<Failure>> createPost(CreatePostInput input) async {
    final options = Options$Mutation$CreatePost(
      variables: Variables$Mutation$CreatePost(
        text: input.text,
        images: await Future.wait(input.images
            .map((e) => MultipartFile.fromPath('', e.path))
            .toList()),
      ),
    );

    final result = await _client.mutate$CreatePost(options);

    if (result.hasException) {
      log('An error occurred while creating the post',
          name: '$this', error: result.exception);

      return Some(ServerFailure());
    }

    return result.parsedData!.createPost.toEntity();
  }

  @override
  Future<Option<Failure>> editPost(
    String postId,
    EditPostInput input,
  ) async {
    final options = Options$Mutation$EditPost(
      variables: Variables$Mutation$EditPost(
        postId: postId,
        input: PostInputMapper.mapEditPostInputToDto(input),
      ),
    );

    final result = await _client.mutate$EditPost(options);

    if (result.hasException) {
      log('An error occurred while editing the post',
          name: '$this', error: result.exception);

      return Some(ServerFailure());
    }

    return result.parsedData!.editPost.toEntity();
  }

  @override
  Stream<Either<Failure, Connection<Post>>> getPosts({
    required int pageSize,
    String? after,
  }) {
    final options = WatchQueryOptions<Connection<Post>>(
      document: documentNodeQueryPosts,
      fetchResults: true,
      variables:
          Variables$Query$Posts(pageSize: pageSize, after: after).toJson(),
      fetchPolicy: _fetchPolicyProvider.fetchPolicy,
    );

    final query = _client.watchQuery<Connection<Post>>(options);

    return mapObservableQuery<Connection<Post>>(
      query,
      (event) => event.parsedData!.posts!.toEntity(),
      (exception) => log(
        'An error occurred while fetching the post list',
        name: '$this',
        error: exception,
      ),
    );
  }

  @override
  Stream<Either<Failure, Post>> subscribeToNewPosts() {
    final stream = _client.subscribe$PostCreated();

    return mapResultStream(
      stream,
      (event) {
        // TODO(exeteres): Update cache rather than clear
        _client.cache.store.reset();

        final result = Subscription$PostCreated.fromJson(event.data!);
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
    final stream = _client.subscribe$PostEdited();

    return mapResultStream(
      stream,
      (event) {
        // TODO(exeteres): Update cache rather than clear
        _client.cache.store.reset();

        final result = Subscription$PostEdited.fromJson(event.data!);
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
    final options = WatchOptions$Query$PostPreviousVersions(
      fetchResults: true,
      variables: Variables$Query$PostPreviousVersions(
        postId: postId,
        after: after,
        pageSize: pageSize,
      ),
      fetchPolicy: _fetchPolicyProvider.fetchPolicy,
    );

    final query = _client.watchQuery$PostPreviousVersions(options);

    return mapObservableQuery(
      query,
      (event) {
        final post = event.parsedData!.post;

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
