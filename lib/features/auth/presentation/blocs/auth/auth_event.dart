import 'package:shetter_app/features/auth/presentation/presentation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authetication() = AuthEventAuthetication;
  const factory AuthEvent.registration() = AuthEventRegistration;
}
