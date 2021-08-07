import 'dart:collection';

import 'package:pansy_arch_auth/domain/domain.dart';

part 'user_info.freezed.dart';

@freezed
class UserInfo with _$UserInfo {
  factory UserInfo({
    required String id,
    required String username,
    required UnmodifiableMapView<String, Object> properties,
  }) = _UserInfo;
}
