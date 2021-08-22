import 'package:pansy_accounts/presentation/presentation.dart';

part 'auth_dialog_event.freezed.dart';

@freezed
class AuthDialogEvent with _$AuthDialogEvent {
  const factory AuthDialogEvent.authetication() = AuthDialogEventAuthetication;
  const factory AuthDialogEvent.registration() = AuthDialogEventRegistration;
}
