import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

typedef PostHistoryBuilder = Widget Function(Connection<Post>, [Failure?]);

@injectable
class PostHistoryBloc extends Bloc<PostHistoryEvent, PostHistoryState> {
  PostHistoryBloc(this._postRepository, @factoryParam Post? post)
      : assert(post != null, "parameter post can not be null"),
        super(PostHistoryState.empty(post: post!)) {
    add(PostHistoryEvent.fetchHistory(post));
  }

  final PostRepository _postRepository;

  @override
  Stream<PostHistoryState> mapEventToState(PostHistoryEvent event) {
    return event.when(
      fetchHistory: (post) => state.maybeWhen(
        empty: (_, __) => _fetchHistory(post: post),
        loaded: (_, connection, __) => _fetchHistory(
          post: post,
          connection: connection,
        ),
        orElse: keep(state),
      ),
      fetchMoreHistory: () => state.maybeWhen(
        loaded: (_, connection, __) => _fetchMoreHistory(connection),
        orElse: keep(state),
      ),
    );
  }

  void fetchMore() {
    add(PostHistoryEvent.fetchMoreHistory());
  }

  void retry() {
    if (state is PostHistoryStateEmpty) {
      return add(PostHistoryEvent.fetchHistory(state.post));
    }

    if (state is PostHistoryStateLoaded) {
      return add(PostHistoryEvent.fetchMoreHistory());
    }
  }

  Future<void> refresh() async {
    await state.maybeWhen(
      loaded: (post, _, __) async {
        add(PostHistoryEvent.fetchHistory(post));
        await stream.firstWhere((element) => element is PostHistoryStateLoaded);
      },
      orElse: () {},
    );
  }

  Stream<PostHistoryState> _fetchHistory({
    Post? post,
    Connection<PostVersion>? connection,
  }) async* {
    final _post = post ?? state.post;

    yield PostHistoryState.loading(post: _post, connection: connection);

    final nextConnectionStream = _postRepository.getPostPreviousVersions(
      state.post.id,
      pageSize: 1,
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
    Connection<PostVersion> connection,
  ) async* {
    if (!connection.pageInfo.hasNextPage) {
      return;
    }

    final _post = state.post;

    yield PostHistoryState.loading(post: _post, connection: connection);

    final nextConnectionStream = _postRepository.getPostPreviousVersions(
      _post.id,
      pageSize: 1,
      after: connection.pageInfo.endCursor,
    );

    yield* nextConnectionStream.map((event) {
      return event.fold(
        (l) => PostHistoryState.loaded(
            post: _post, connection: connection, failure: l),
        (r) => PostHistoryState.loaded(
          post: _post,
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
    return events.debounceTime(100.milliseconds).switchMap(transitionFn);
  }
}
