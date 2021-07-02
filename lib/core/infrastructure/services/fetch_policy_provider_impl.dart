import 'package:graphql/client.dart';
import 'package:shetter_app/core/infrastructure/infrastructure.dart';

@LazySingleton(as: FetchPolicyProvider)
class FetchPolicyProviderImpl implements FetchPolicyProvider {
  FetchPolicyProviderImpl(this._networkManager);

  final NetworkManager _networkManager;

  FetchPolicy get fetchPolicy => _networkManager.isOnline
      ? FetchPolicy.networkOnly
      : FetchPolicy.cacheOnly;
}
