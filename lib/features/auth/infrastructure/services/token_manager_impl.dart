import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/infrastructure/infrastructure.dart';

@Singleton(as: TokenManager)
class TokenManagerImpl implements TokenManager {
  TokenManagerImpl(this._box);

  final Box _box;

  TokenPair? _tokens;
  UserInfo? _userInfo;

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
  UserInfo get userInfo {
    if (_userInfo == null) {
      throw Exception("User is not authenticated");
    }

    return _userInfo!;
  }

  @override
  Future<void> setTokens(TokenPair tokenPair) async {
    _tokens = tokenPair;
    _updateUserInfo();

    await _box.putAll({
      "access_token": tokenPair.accessToken.value,
      "refresh_token": tokenPair.refreshToken
    });
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

    _updateUserInfo();
  }

  void _updateUserInfo() {
    final payload = tokens.accessToken.payload;

    _userInfo = UserInfo(
      id: payload.userId,
      username: payload.username,
    );
  }

  @factoryMethod
  static Future<TokenManager> create(Box box) async {
    final tokenManager = TokenManagerImpl(box);
    await tokenManager.load();

    return tokenManager;
  }
}
