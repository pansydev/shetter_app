import 'package:shetter_app/features/auth/domain/domain.dart';

abstract class TokenManager {
  bool get authenticated;
  bool get expired;

  TokenPair get tokens;

  AuthenticationState get state;
  Stream<AuthenticationState> subscribe();

  Future<void> setTokens(TokenPair tokenPair);
  Future<void> clearTokens();
}
