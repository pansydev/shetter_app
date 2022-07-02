import 'package:pansy_arch_auth/domain/domain.dart';

abstract class AuthenticationStateManager {
  AuthenticationState get state;
  Stream<AuthenticationState> subscribe();

  Future<void> logout();
}
