import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

typedef PostListBuilder = Widget Function(Connection<Post>, [Failure?]);

@injectable
class PostListBloc extends Bloc<PostListEvent, PostListState> {
  PostListBloc(this._postRepository) : super(PostListState.empty()) {
    _postRepository
        .subscribeToNewPosts()
        .listen((post) => add(PostListEvent.postCreated(post)));

    _postRepository
        .subscribeToEditedPosts()
        .listen((post) => add(PostListEvent.postEdited(post)));
  }

  final PostRepository _postRepository;

  static const double minChildHeight = uPostMinHeight;

  @override
  Stream<PostListState> mapEventToState(PostListEvent event) {
    return event.when(
      fetchPosts: (size) => state.maybeWhen(
        empty: (_) => _fetchPosts(size),
        loaded: (connection, _) => _fetchPosts(size, connection),
        orElse: keep(state),
      ),
      fetchMorePosts: (size) => state.maybeWhen(
        loaded: (connection, _) => _fetchMorePosts(size, connection),
        orElse: keep(state),
      ),
      postCreated: (post) => state.maybeWhen(
        loaded: (connection, failure) =>
            _postCreated(post, connection, failure),
        loadingMore: (connection) => _postCreated(post, connection),
        orElse: keep(state),
      ),
      postEdited: (post) => state.maybeWhen(
        loaded: (connection, failure) => _postEdited(post, connection, failure),
        loadingMore: (connection) => _postEdited(post, connection),
        orElse: keep(state),
      ),
    );
  }

  void fetchMore(int size) {
    if (state is PostListStateEmpty) {
      return add(PostListEvent.fetchPosts(size));
    }

    if (state is PostListStateLoaded) {
      return add(PostListEvent.fetchMorePosts(size));
    }
  }

  void retry(BuildContext context) {
    final size = UPaginate.getPageSizeWithContext(
      context,
      minChildHeight: minChildHeight,
    );

    fetchMore(size);
  }

  Stream<PostListState> _fetchPosts(
    int size, [
    Connection<Post>? connection,
  ]) async* {
    yield PostListState.loading(connection: connection);

    final nextConnectionStream = _postRepository.getPosts(
      pageSize: size,
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

  Stream<PostListState> _fetchMorePosts(
    int size,
    Connection<Post> connection,
  ) async* {
    if (!connection.pageInfo.hasNextPage) {
      return;
    }

    yield PostListState.loading(connection: connection);

    final nextConnectionStream = _postRepository.getPosts(
      pageSize: size,
      after: connection.pageInfo.endCursor,
    );

    yield* nextConnectionStream.map((event) {
      return event.fold(
        (l) => PostListState.loaded(connection: connection, failure: l),
        (r) => PostListState.loaded(
          connection: connection.copyWith(
            nodes: UnmodifiableListView(connection.nodes + r.nodes),
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
          nodes: UnmodifiableListView(connection.nodes.prepend(r)),
        ),
        failure: failure,
      ),
    );
  }

  Stream<PostListState> _postEdited(
    Either<Failure, Post> post,
    Connection<Post> connection, [
    Failure? failure,
  ]) async* {
    yield post.fold(
      (l) => PostListState.loaded(
        connection: connection,
        failure: l,
      ),
      (edited) => PostListState.loaded(
        connection: connection.copyWith(
          nodes: UnmodifiableListView(
            connection.nodes.map((old) => old.id == edited.id ? edited : old),
          ),
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
    return events.debounceTime(100.milliseconds).switchMap(transitionFn);
  }
}
