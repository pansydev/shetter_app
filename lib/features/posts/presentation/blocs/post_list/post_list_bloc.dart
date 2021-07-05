import 'package:injectable/injectable.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

typedef PostListBuilder = Widget Function(Connection<Post>, [Failure?]);

@injectable
class PostListBloc extends Bloc<PostListEvent, PostListState> {
  PostListBloc(this._postRepository) : super(PostListState.empty()) {
    add(PostListEvent.fetchPosts());

    _postRepository
        .subsribeToPosts()
        .listen((post) => add(PostListEvent.postCreated(post)));
  }

  final PostRepository _postRepository;

  static const int _pageSize = 35;

  @override
  Stream<PostListState> mapEventToState(PostListEvent event) {
    return event.when(
      fetchPosts: () => state.maybeWhen(
        empty: (_) => _fetchPosts(),
        loaded: (connection, _) => _fetchPosts(connection),
        orElse: keep(state),
      ),
      fetchMorePosts: () => state.maybeWhen(
        loaded: (connection, _) => _fetchMorePosts(connection),
        orElse: keep(state),
      ),
      postCreated: (post) => state.maybeWhen(
        loaded: (connection, failure) =>
            _postCreated(post, connection, failure),
        loadingMore: (connection) => _postCreated(post, connection),
        orElse: keep(state),
      ),
    );
  }

  void fetchMore() {
    add(PostListEvent.fetchMorePosts());
  }

  void retry() {
    if (state is PostListStateEmpty) {
      return add(PostListEvent.fetchPosts());
    }

    if (state is PostListStateLoaded) {
      return add(PostListEvent.fetchMorePosts());
    }
  }

  Future<void> refresh() async {
    add(PostListEvent.fetchPosts());
    await stream.firstWhere((element) => element is PostListStateLoaded);
  }

  Stream<PostListState> _fetchPosts([Connection<Post>? connection]) async* {
    yield PostListState.loading(connection: connection);

    final nextConnectionStream = _postRepository.getPosts(
      pageSize: _pageSize,
    );

    yield* nextConnectionStream.map((event) {
      return event.fold(
        (l) => connection == null
            ? PostListState.empty(failure: l)
            : PostListState.loaded(connection: connection, failure: l),
        (r) => PostListState.loaded(connection: r),
      );
    });
  }

  Stream<PostListState> _fetchMorePosts(Connection<Post> connection) async* {
    if (!connection.pageInfo.hasNextPage) {
      return;
    }

    yield PostListState.loading(connection: connection);

    final nextConnectionStream = _postRepository.getPosts(
      pageSize: _pageSize,
      after: connection.pageInfo.endCursor,
    );

    yield* nextConnectionStream.map((event) {
      return event.fold(
        (l) => PostListState.loaded(connection: connection, failure: l),
        (r) => PostListState.loaded(
          connection: connection.copyWith(
            nodes: connection.nodes.plus(r.nodes),
            pageInfo: r.pageInfo,
          ),
        ),
      );
    });
  }

  Stream<PostListState> _postCreated(
    Either<Failure, Post> post,
    Connection<Post> connection, [
    Failure? failure,
  ]) async* {
    yield post.fold(
      (l) => PostListState.loaded(
        connection: connection,
        failure: l,
      ),
      (r) => PostListState.loaded(
        connection: connection.copyWith(
          nodes: connection.nodes.prependElement(r),
        ),
        failure: failure,
      ),
    );
  }

  @override
  Stream<Transition<PostListEvent, PostListState>> transformEvents(
    Stream<PostListEvent> events,
    transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 100))
        .switchMap(transitionFn);
  }
}
