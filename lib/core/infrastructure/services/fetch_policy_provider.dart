import 'package:graphql/client.dart';

abstract class FetchPolicyProvider {
  FetchPolicy get fetchPolicy;
}
