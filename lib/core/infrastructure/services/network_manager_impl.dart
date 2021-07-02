import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shetter_app/core/infrastructure/infrastructure.dart';

@Singleton(as: NetworkManager)
class NetworkManagerImpl implements NetworkManager {
  late ConnectivityResult _connectivityResult;

  Future init() async {
    final connectivity = Connectivity();
    _connectivityResult = await connectivity.checkConnectivity();

    connectivity.onConnectivityChanged.listen((event) {
      _connectivityResult = event;
    });
  }

  @override
  bool get isOnline => _connectivityResult != ConnectivityResult.none;

  @factoryMethod
  static Future<NetworkManager> create() async {
    final networkManager = NetworkManagerImpl();
    await networkManager.init();
    return networkManager;
  }
}
