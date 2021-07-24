import 'package:pansy_arch_graphql/infrastructure/infrastructure.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';
import 'package:hive_flutter/hive_flutter.dart';

@module
abstract class HiveBoxFactory {
  @preResolve
  @Singleton(env: ["pansy_accounts"])
  Future<Box> createHiveBox() async {
    await Hive.initFlutter();

    return Hive.openBox(AccountsInfrastructureConstants.boxName);
  }
}
