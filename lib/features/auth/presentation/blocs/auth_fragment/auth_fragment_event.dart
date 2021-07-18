import 'package:shetter_app/features/auth/presentation/presentation.dart';

part 'auth_fragment_event.freezed.dart';

@freezed
class AuthFragmentEvent with _$AuthFragmentEvent {
  const factory AuthFragmentEvent.authetication() =
      AuthFragmentEventAuthetication;
  const factory AuthFragmentEvent.registration() =
      AuthFragmentEventRegistration;
}
