import 'dart:async';

import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

@Singleton(as: TokenManager)
class TokenManagerImpl implements TokenManager {
  TokenManagerImpl(this._box);

  final Box _box;

  TokenPair? _tokens;

  @override
  bool get authenticated => _tokens != null;

  @override
  bool get expired =>
      tokens.accessToken.payload.expirationTime.isBefore(DateTime.now());

  @override
  TokenPair get tokens {
    if (_tokens == null) {
      throw Exception("User is not authenticated");
    }

    return _tokens!;
  }

  @override
  Future<void> setTokens(TokenPair tokenPair) async {
    _tokens = tokenPair;
    _updateAuthenticationState();

    await _box.putAll({
      "access_token": tokenPair.accessToken.value,
      "refresh_token": tokenPair.refreshToken
    });
  }

  @override
  Future<void> clearTokens() async {
    _tokens = null;
    _updateAuthenticationState();

    await _box.deleteAll(["access_token", "refresh_token"]);
  }

  Future<void> load() async {
    final String? accessToken = _box.get("access_token");
    final String? refreshToken = _box.get("refresh_token");

    if (accessToken == null || refreshToken == null) {
      return;
    }

    _tokens = TokenPair(
      accessToken: AccessTokenMapper.toEntity(accessToken),
      refreshToken: refreshToken,
    );

    _updateAuthenticationState();
  }

  void _updateAuthenticationState() {
    _authenticationState = AuthenticationState(
      authenticated: authenticated,
      userInfo: _buildUserInfo(),
    );

    _stateController.add(_authenticationState);
  }

  UserInfo? _buildUserInfo() {
    if (!authenticated) return null;

    final payload = tokens.accessToken.payload;

    return UserInfo(
      id: payload.userId,
      username: payload.username,
      properties: UnmodifiableMapView({}),
    );
  }

  final StreamController<AuthenticationState> _stateController =
      StreamController();

  AuthenticationState _authenticationState =
      AuthenticationState(authenticated: false);

  @override
  AuthenticationState get state => _authenticationState;

  @override
  Stream<AuthenticationState> subscribe() {
    return _stateController.stream.asBroadcastStream();
  }

  @factoryMethod
  static Future<TokenManager> create(@Named("pansy_accounts") Box box) async {
    final tokenManager = TokenManagerImpl(box);
    await tokenManager.load();

    return tokenManager;
  }
}
