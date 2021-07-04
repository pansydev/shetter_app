import 'package:shetter_app/core/domain/domain.dart';

abstract class UserInfoProvider {
  bool get authenticated;
  UserInfo get userInfo;
}
