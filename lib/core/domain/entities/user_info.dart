import 'package:shetter_app/core/domain/domain.dart';

part 'user_info.freezed.dart';

@freezed
class UserInfo with _$UserInfo {
  factory UserInfo({
    required String id,
    required String username,
  }) = _UserInfo;
}
