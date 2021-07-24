import 'package:pansy_arch_graphql/infrastructure/infrastructure.dart';

@LazySingleton(as: FetchPolicyProvider)
class FetchPolicyProviderImpl implements FetchPolicyProvider {
  FetchPolicyProviderImpl(this._networkManager);

  final NetworkManager _networkManager;

  FetchPolicy get fetchPolicy => _networkManager.isOnline
      ? FetchPolicy.cacheAndNetwork
      : FetchPolicy.cacheOnly;
}
