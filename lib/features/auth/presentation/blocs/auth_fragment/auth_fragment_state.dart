import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/presentation/presentation.dart';

part 'auth_fragment_state.freezed.dart';

@freezed
class AuthFragmentState with _$AuthFragmentState {
  const factory AuthFragmentState.initial({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) = AuthFragmentStateInitial;
  const factory AuthFragmentState.loading({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) = AuthFragmentStateLoading;
  const factory AuthFragmentState.error({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
    required Failure failure,
  }) = AuthFragmentStateError;
  const factory AuthFragmentState.autheticated({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) = AuthFragmentStateAuthenticated;
}
