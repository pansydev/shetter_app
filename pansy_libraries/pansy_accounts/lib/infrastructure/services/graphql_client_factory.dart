import 'package:pansy_accounts/infrastructure/infrastructure.dart';
import 'package:pansy_arch_graphql/infrastructure/infrastructure.dart';

@module
abstract class GraphQLClientFactory {
  @LazySingleton(env: ["pansy_accounts"])
  GraphQLClient createClient(
    AuthLinkFactory linkFactory,
    Box box,
  ) {
    final transportLink = createTransportLink();

    return GraphQLClientFactoryHelper.createClient(
      linkFactory,
      box,
      transportLink,
    );
  }

  Link createTransportLink() {
    final httpLink = HttpLink(AccountsInfrastructureConstants.httpApiUrl);
    final wsLink = WebSocketLink(AccountsInfrastructureConstants.wsApiUrl);

    return Link.split(
      (request) => request.isSubscription,
      wsLink,
      httpLink,
    );
  }
}
