import 'package:pansy_accounts/domain/domain.dart';

abstract class AuthRepository {
  Future<Either<Failure, TokenPair>> auth(String username, String password);
  Future<Either<Failure, TokenPair>> register(String username, String password);
}
