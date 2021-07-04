import 'package:graphql/client.dart';

abstract class AuthLinkFactory {
  Link createAuthLink();
}
