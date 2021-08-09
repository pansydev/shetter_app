import 'package:pansy_accounts/infrastructure/infrastructure.dart';

@module
abstract class GraphQLClientFactory {
  @Named('pansy_accounts')
  @lazySingleton
  GraphQLClient createClient(
    AuthLinkFactory linkFactory,
    @Named('pansy_accounts') Box box,
  ) {
    final transportLink = _createTransportLink();

    return GraphQLClientFactoryHelper.createClient(
      linkFactory,
      box,
      transportLink,
    );
  }

  Link _createTransportLink() {
    final httpLink = HttpLink(AccountsInfrastructureConstants.httpApiUrl);
    final wsLink = WebSocketLink(AccountsInfrastructureConstants.wsApiUrl);

    return Link.split(
      (request) => request.isSubscription,
      wsLink,
      httpLink,
    );
  }
}
