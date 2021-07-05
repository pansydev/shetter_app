import 'package:shetter_app/features/auth/domain/domain.dart';

@LazySingleton(as: AuthenticationStateProvider)
class AuthenticationStateProviderImpl implements AuthenticationStateProvider {
  AuthenticationStateProviderImpl(this._tokenManager);

  final TokenManager _tokenManager;

  @override
  AuthenticationState get state => _tokenManager.state;

  @override
  Stream<AuthenticationState> subscribe() => _tokenManager.subscribe();
}
