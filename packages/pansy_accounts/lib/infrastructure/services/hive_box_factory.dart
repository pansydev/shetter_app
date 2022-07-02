import 'package:pansy_accounts/infrastructure/infrastructure.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxFactory implements Initializable {
  late Box box;

  @override
  Future initialize() async {
    await Hive.initFlutter();
    box = await Hive.openBox(AccountsInfrastructureConstants.boxName);
  }

  static Box create(ServiceProvider sp) {
    return sp.getRequired<HiveBoxFactory>().box;
  }
}
