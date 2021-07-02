import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@module
abstract class GraphQLClientFactory {
  @singleton
  Future<GraphQLClient> createClient() async {
    final httpLink = HttpLink(InfrastructureConstants.httpApiUrl);
    final wsLink = WebSocketLink(InfrastructureConstants.wsApiUrl);

    final link = Link.split(
      (request) => request.isSubscription,
      wsLink,
      httpLink,
    );

    await Hive.initFlutter();

    final box = await Hive.openBox(InfrastructureConstants.appId);
    final store = HiveStore(box);
    final cache = GraphQLCache(store: store);

    return GraphQLClient(link: link, cache: cache);
  }
}
