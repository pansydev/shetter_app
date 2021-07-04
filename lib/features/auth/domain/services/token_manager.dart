import 'package:shetter_app/features/auth/domain/domain.dart';

abstract class TokenManager {
  bool get authenticated;
  bool get expired;

  TokenPair get tokens;
  UserInfo get userInfo;

  Future<void> setTokens(TokenPair tokenPair);
}
