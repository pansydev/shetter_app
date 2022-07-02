import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._client,
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

    final options = Options$Mutation$Auth(
      variables: Variables$Mutation$Auth(
        username: username,
        password: password,
        audience: pansyAccountsOptions.audience,
      ),
    );

    final result = await _client.mutate$Auth(options);

    if (result.hasException) {
      log('${result.exception}', name: '$this');
      return Left(ServerFailure());
    }

    return result.parsedData!.auth.toEntity();
  }

  @override
  Future<Either<Failure, TokenPair>> register(
    String username,
    String password,
  ) async {
    final pansyAccountsOptions = _optionsManager.get<PansyAccountsOptions>();

    final options = Options$Mutation$Register(
      variables: Variables$Mutation$Register(
        username: username,
        password: password,
        audience: pansyAccountsOptions.audience,
      ),
    );

    final result = await _client.mutate$Register(options);

    if (result.hasException) {
      log('${result.exception}', name: '$this');
      return Left(ServerFailure());
    }

    return result.parsedData!.register.toEntity();
  }
}
