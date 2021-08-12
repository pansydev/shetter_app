import 'package:pansy_accounts/domain/domain.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  factory AuthEvent.authenticationStateChanged(AuthenticationState state) =
      AuthEventAuthenticationStateChanged;
}
