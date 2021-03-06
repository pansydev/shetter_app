import 'package:pansy_accounts/domain/domain.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState.authenticated({
    required UserInfo userInfo,
  }) = AuthStateAuthenticated;

  factory AuthState.unauthenticated() = AuthStateUnauthenticated;
}
