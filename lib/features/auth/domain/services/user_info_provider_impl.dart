import 'package:shetter_app/features/auth/domain/domain.dart';

@LazySingleton(as: UserInfoProvider)
class UserInfoProviderImpl implements UserInfoProvider {
  UserInfoProviderImpl(this._tokenManager);

  final TokenManager _tokenManager;

  @override
  bool get authenticated => _tokenManager.authenticated;

  @override
  UserInfo get userInfo => _tokenManager.userInfo;
}
