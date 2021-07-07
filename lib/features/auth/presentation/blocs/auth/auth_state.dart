import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/presentation/presentation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) = AuthStateInitial;
  const factory AuthState.loading({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) = AuthStateLoading;
  const factory AuthState.error({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
    required Failure failure,
  }) = AuthStateError;
  const factory AuthState.autheticated({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) = AuthStateAuthenticated;
}
