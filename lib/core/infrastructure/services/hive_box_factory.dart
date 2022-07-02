import 'package:shetter_app/core/infrastructure/infrastructure.dart';

class HiveBoxFactory implements Initializable {
  late Box box;

  @override
  Future initialize() async {
    box = await Hive.openBox(InfrastructureConstants.appId);
  }

  static Box create(ServiceProvider sp) {
    return sp.getRequired<HiveBoxFactory>().box;
  }
}
