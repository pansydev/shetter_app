import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

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
    assert(_tokenManager.authenticated, 'User is not authenticated');

    final options = Options$Mutation$Refresh(
      variables: Variables$Mutation$Refresh(
        refreshToken: _tokenManager.tokens.refreshToken,
      ),
    );

    final client = _provider.getRequired<GraphQLClient>();

    final result = await client.mutate$Refresh(options);

    if (result.hasException) {
      log('${result.exception}', name: '$this');
      return Some(ServerFailure());
    }

    final tokenPair = result.parsedData!.refresh.toEntity();

    return await tokenPair.fold(
      (l) => Some(ServerFailure()),
      (r) async {
        await _tokenManager.setTokens(r);
        return None();
      },
    );
  }
}
