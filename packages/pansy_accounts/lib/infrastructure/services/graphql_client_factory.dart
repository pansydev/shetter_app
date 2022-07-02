import 'package:pansy_accounts/infrastructure/infrastructure.dart';

abstract class GraphQLClientFactory {
  GraphQLClient createClient(
    AuthLinkFactory linkFactory,
    Box<Map> box,
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
