import 'package:shetter_app/core/domain/domain.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  factory AuthenticationState({
    required bool authenticated,
    UserInfo? userInfo,
  }) = _AuthenticationState;
}
