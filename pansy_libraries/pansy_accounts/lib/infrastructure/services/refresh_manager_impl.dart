import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

@LazySingleton(as: RefreshManager)
class RefreshManagerImpl implements RefreshManager {
  RefreshManagerImpl(this._tokenManager, this._provider);

  final TokenManager _tokenManager;
  final ServiceProvider _provider;

  Future<Option<Failure>>? _runningRefresh;

  @override
  Future<Option<Failure>> ensureRefreshed({bool force = false}) async {
    if (_runningRefresh != null) {
      return _runningRefresh!;
    }

    return _runningRefresh = _ensureRefreshed(force).then((value) {
      _runningRefresh = null;
      return value;
    });
  }

  Future<Option<Failure>> _ensureRefreshed(bool force) async {
    if (_tokenManager.expired || force) {
      return refresh();
    }

    return None();
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
