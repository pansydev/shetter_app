import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info.freezed.dart';

@freezed
class UserInfo with _$UserInfo {
  factory UserInfo({
    required String id,
    required String username,
  }) = _UserInfo;
}
