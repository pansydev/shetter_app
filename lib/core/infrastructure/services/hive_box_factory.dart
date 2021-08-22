import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:hive_flutter/hive_flutter.dart';

@module
abstract class HiveBoxFactory {
  @preResolve
  @singleton
  Future<Box> createHiveBox() async {
    return Hive.openBox(InfrastructureConstants.appId);
  }
}
