import 'package:shetter_app/core/domain/domain.dart';

abstract class AuthenticationStateProvider {
  AuthenticationState get state;
  Stream<AuthenticationState> subscribe();
}
