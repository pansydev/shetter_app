import 'package:pansy_accounts/domain/domain.dart';

class AuthManagerImpl implements AuthManager {
  AuthManagerImpl(this._authRepository, this._tokenManager);

  final AuthRepository _authRepository;
  final TokenManager _tokenManager;

  @override
  Future<Option<Failure>> auth(String username, String password) async {
    final result = await _authRepository.auth(username, password);

    return updateTokens(result);
  }

  @override
  Future<Option<Failure>> register(String username, String password) async {
    final result = await _authRepository.register(username, password);

    return updateTokens(result);
  }

  Future<Option<Failure>> updateTokens(
    Either<Failure, TokenPair> result,
  ) async {
    return result.fold(
      (l) => Some(l),
      (r) async {
        await _tokenManager.setTokens(r);
        return None();
      },
    );
  }
}
