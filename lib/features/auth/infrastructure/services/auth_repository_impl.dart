import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/infrastructure/infrastructure.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<Either<Failure, TokenPair>> auth(
    String username,
    String password,
  ) async {
    final options = GQLOptionsMutationAuth(
      variables: VariablesMutationAuth(username: username, password: password),
    );

    final result = await _client.mutateAuth(options);

    if (result.hasException) {
      return Left(ServerFailure());
    }

    return result.parsedDataMutationAuth!.auth.toEntity();
  }

  @override
  Future<Either<Failure, TokenPair>> register(
    String username,
    String password,
  ) async {
    final options = GQLOptionsMutationRegister(
      variables: VariablesMutationRegister(
        username: username,
        password: password,
      ),
    );

    final result = await _client.mutateRegister(options);

    if (result.hasException) {
      return Left(ServerFailure());
    }

    return result.parsedDataMutationRegister!.register.toEntity();
  }
}
