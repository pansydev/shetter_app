import 'package:shetter_app/core/domain/domain.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  factory AuthEvent.authenticationStateChanged(AuthenticationState state) =
      AuthEventAuthenticationStateChanged;
}
