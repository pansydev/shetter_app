import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    @Named("pansy_accounts") this._client,
    this._optionsManager,
  );

  final GraphQLClient _client;
  final OptionsManager _optionsManager;

  @override
  Future<Either<Failure, TokenPair>> auth(
    String username,
    String password,
  ) async {
    final pansyAccountsOptions = _optionsManager.get<PansyAccountsOptions>();

    final options = GQLOptionsMutationAuth(
      variables: VariablesMutationAuth(
        username: username,
        password: password,
        audience: pansyAccountsOptions.audience,
      ),
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
