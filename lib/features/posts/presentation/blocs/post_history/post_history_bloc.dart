import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

typedef PostHistoryBuilder = Widget Function(
  Post,
  Connection<PostVersion>, [
  Failure?,
]);

@injectable
class PostHistoryBloc extends Bloc<PostHistoryEvent, PostHistoryState> {
  PostHistoryBloc(this._postRepository, @factoryParam Post? post)
      : assert(post != null, 'parameter post can not be null'),
        super(PostHistoryState.empty(post: post!));

  final PostRepository _postRepository;

  static const double minChildHeight = uPostMinHeight;

  @override
  Stream<PostHistoryState> mapEventToState(PostHistoryEvent event) {
    return event.when(
      fetchHistory: (post, size) => state.maybeWhen(
        empty: (_, __) => _fetchHistory(size, post),
        loaded: (_, connection, __) => _fetchHistory(
          size,
          post,
          connection,
        ),
        orElse: keep(state),
      ),
      fetchMoreHistory: (size) => state.maybeWhen(
        loaded: (_, connection, __) => _fetchMoreHistory(size, connection),
        orElse: keep(state),
      ),
    );
  }

  void fetchMore(int size) {
    if (state is PostHistoryStateEmpty) {
      return add(PostHistoryEvent.fetchHistory(state.post, size));
    }

    if (state is PostHistoryStateLoaded) {
      return add(PostHistoryEvent.fetchMoreHistory(size));
    }
  }

  void retry(BuildContext context) {
    final size = UPaginate.getPageSizeWithContext(
      context,
      minChildHeight: minChildHeight,
    );

    fetchMore(size);
  }

  Stream<PostHistoryState> _fetchHistory(
    int size, [
    Post? post,
    Connection<PostVersion>? connection,
  ]) async* {
    final _post = post ?? state.post;

    yield PostHistoryState.loading(post: _post, connection: connection);

    final nextConnectionStream = _postRepository.getPostPreviousVersions(
      state.post.id,
      pageSize: size,
    );

    yield* nextConnectionStream.map((event) {
      return event.fold(
        (l) => connection == null
            ? PostHistoryState.empty(post: _post, failure: l)
            : PostHistoryState.loaded(
                post: _post,
                connection: connection,
                failure: l,
              ),
        (r) => PostHistoryState.loaded(
          post: _post,
          connection: r,
        ),
      );
    });
  }

  Stream<PostHistoryState> _fetchMoreHistory(
    int size,
    Connection<PostVersion> connection,
  ) async* {
    if (!connection.pageInfo.hasNextPage) {
      return;
    }

    final post = state.post;

    yield PostHistoryState.loading(post: post, connection: connection);

    final nextConnectionStream = _postRepository.getPostPreviousVersions(
      post.id,
      pageSize: size,
      after: connection.pageInfo.endCursor,
    );

    yield* nextConnectionStream.map((event) {
      return event.fold(
        (l) => PostHistoryState.loaded(
          post: post,
          connection: connection,
          failure: l,
        ),
        (r) => PostHistoryState.loaded(
          post: post,
          connection: connection.copyWith(
            nodes: UnmodifiableListView(connection.nodes + r.nodes),
            pageInfo: r.pageInfo,
          ),
        ),
      );
    });
  }

  @override
  Stream<Transition<PostHistoryEvent, PostHistoryState>> transformEvents(
    Stream<PostHistoryEvent> events,
    transitionFn,
  ) {
    // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
    return events.debounceTime(100.milliseconds).switchMap(transitionFn);
  }
}
