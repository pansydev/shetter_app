import 'package:shetter_app/core/infrastructure/infrastructure.dart';

@module
abstract class HiveBoxFactory {
  @preResolve
  @singleton
  Future<Box> createHiveBox() async {
    return Hive.openBox(InfrastructureConstants.appId);
  }
}
