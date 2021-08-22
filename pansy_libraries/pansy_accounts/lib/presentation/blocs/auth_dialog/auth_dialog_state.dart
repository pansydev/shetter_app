import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/presentation/presentation.dart';

part 'auth_dialog_state.freezed.dart';

@freezed
class AuthDialogState with _$AuthDialogState {
  const factory AuthDialogState.initial({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) = AuthDialogStateInitial;
  const factory AuthDialogState.loading({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) = AuthDialogStateLoading;
  const factory AuthDialogState.error({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
    required Failure failure,
  }) = AuthDialogStateError;
}
