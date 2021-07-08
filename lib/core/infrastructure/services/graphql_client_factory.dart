import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@module
abstract class GraphQLClientFactory {
  @lazySingleton
  GraphQLClient createClient(
    AuthLinkFactory linkFactory,
    Box box,
  ) {
    final httpLink = HttpLink(InfrastructureConstants.httpApiUrl);
    final wsLink = WebSocketLink(InfrastructureConstants.wsApiUrl);

    final transportLink = Link.split(
      (request) => request.isSubscription,
      wsLink,
      httpLink,
    );

    final authLink = linkFactory.createAuthLink();

    final link = Link.from([transportLink, authLink]);

    final store = HiveStore(box);
    final cache = GraphQLCache(store: store);

    return GraphQLClient(link: link, cache: cache);
  }
}
