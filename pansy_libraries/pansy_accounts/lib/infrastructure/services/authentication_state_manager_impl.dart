import 'package:pansy_accounts/domain/domain.dart';

@LazySingleton(as: AuthenticationStateManager)
class AuthenticationStateManagerImpl implements AuthenticationStateManager {
  AuthenticationStateManagerImpl(this._tokenManager);

  final TokenManager _tokenManager;

  @override
  AuthenticationState get state => _tokenManager.state;

  @override
  Stream<AuthenticationState> subscribe() => _tokenManager.subscribe();

  @override
  Future<void> logout() async {
    await _tokenManager.clearTokens();
  }
}
