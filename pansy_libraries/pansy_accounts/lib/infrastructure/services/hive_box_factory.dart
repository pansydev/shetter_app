import 'package:pansy_accounts/infrastructure/infrastructure.dart';
import 'package:hive_flutter/hive_flutter.dart';

@module
abstract class HiveBoxFactory {
  @preResolve
  @Named('pansy_accounts')
  @singleton
  Future<Box> createHiveBox() async {
    await Hive.initFlutter();

    return Hive.openBox(AccountsInfrastructureConstants.boxName);
  }
}
