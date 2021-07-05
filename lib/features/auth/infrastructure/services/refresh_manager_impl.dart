import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/infrastructure/infrastructure.dart';

@LazySingleton(as: RefreshManager)
class RefreshManagerImpl implements RefreshManager {
  RefreshManagerImpl(this._tokenManager, this._provider);

  final TokenManager _tokenManager;
  final ServiceProvider _provider;

  Future<Option<Failure>>? _runningRefresh;

  @override
  Future<Option<Failure>> ensureRefreshed({bool force = false}) {
    if (_runningRefresh != null) {
      return _runningRefresh!;
    }

    if (_tokenManager.expired || force) {
      return _runningRefresh = refresh();
    }

    return Future.value(None());
  }

  Future<Option<Failure>> refresh() async {
    assert(_tokenManager.authenticated, "User is not authenticated");

    final options = GQLOptionsMutationRefresh(
      variables: VariablesMutationRefresh(
        refreshToken: _tokenManager.tokens.refreshToken,
      ),
    );

    final client = _provider.resolve<GraphQLClient>();

    final result = await client.mutateRefresh(options);

    if (result.hasException) {
      return Some(ServerFailure());
    }

    final tokenPair = result.parsedDataMutationRefresh!.refresh.toEntity();

    return await tokenPair.fold(
      (l) => Some(ServerFailure()),
      (r) async {
        await _tokenManager.setTokens(r);
        return None();
      },
    );
  }
}
