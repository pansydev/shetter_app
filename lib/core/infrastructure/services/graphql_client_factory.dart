import 'package:shetter_app/core/infrastructure/infrastructure.dart';

@module
abstract class GraphQLClientFactory {
  @lazySingleton
  GraphQLClient createClient(
    AuthLinkFactory linkFactory,
    Box box,
  ) {
    final transportLink = _createTransportLink();

    return GraphQLClientFactoryHelper.createClient(
      linkFactory,
      box,
      transportLink,
    );
  }

  Link _createTransportLink() {
    final httpLink = HttpLink(InfrastructureConstants.httpApiUrl);
    final wsLink = WebSocketLink(InfrastructureConstants.wsApiUrl);

    return Link.split(
      (request) => request.isSubscription,
      wsLink,
      httpLink,
    );
  }
}
