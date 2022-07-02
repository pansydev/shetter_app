import 'package:pansy_arch_graphql/infrastructure/infrastructure.dart';

abstract class GraphQLClientFactoryHelper {
  static GraphQLClient createClient(
    AuthLinkFactory linkFactory,
    Box<Map> box,
    Link transportLink,
  ) {
    final authLink = linkFactory.createAuthLink();

    final link = Link.from([authLink, transportLink]);

    final store = HiveStore(box);
    final cache = GraphQLCache(store: store);

    return GraphQLClient(link: link, cache: cache);
  }
}
