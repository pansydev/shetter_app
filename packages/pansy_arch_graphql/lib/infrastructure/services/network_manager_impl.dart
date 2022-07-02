import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pansy_arch_graphql/infrastructure/infrastructure.dart';

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

  static Future<NetworkManager> create() async {
    final networkManager = NetworkManagerImpl();
    await networkManager.init();

    return networkManager;
  }
}
