import 'package:shetter_app/core/domain/domain.dart';

abstract class AuthenticationStateManager {
  AuthenticationState get state;
  Stream<AuthenticationState> subscribe();

  Future<void> logout();
}
