import 'package:shetter_app/features/auth/domain/domain.dart';

abstract class AuthManager {
  Future<Option<Failure>> auth(String username, String password);
  Future<Option<Failure>> register(String username, String password);
  Future<void> logout();
}
