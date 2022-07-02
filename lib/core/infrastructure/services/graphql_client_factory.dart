import 'package:shetter_app/core/infrastructure/infrastructure.dart';

class GraphQLClientFactory {
  static GraphQLClient _createClient(
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

  static Link _createTransportLink() {
    final httpLink = HttpLink(InfrastructureConstants.httpApiUrl);
    final wsLink = WebSocketLink(InfrastructureConstants.wsApiUrl);

    return Link.split(
      (request) => request.isSubscription,
      wsLink,
      httpLink,
    );
  }

  static GraphQLClient create(ServiceProvider sp) {
    return _createClient(
      sp.getRequired<AuthLinkFactory>(),
      sp.getRequired<Box<Map>>(),
    );
  }
}
