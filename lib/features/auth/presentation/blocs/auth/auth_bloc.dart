import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/presentation/presentation.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authManager)
      : super(AuthState.initial(
          usernameController: TextEditingController(),
          passwordController: TextEditingController(),
        ));

  final AuthManager _authManager;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) {
    return event.when(
      authetication: () => state.maybeWhen(
        initial: _auth,
        error: _auth,
        orElse: keep(state),
      ),
      registration: () => state.maybeWhen(
        initial: _register,
        error: _register,
        orElse: keep(state),
      ),
    );
  }

  void auth() {
    if (state is AuthStateLoading) return;
    add(AuthEvent.authetication());
  }

  void register() {
    if (state is AuthStateLoading) return;
    add(AuthEvent.registration());
  }

  Stream<AuthState> _auth(
    TextEditingController usernameController,
    TextEditingController passwordController, [
    Failure? failure,
  ]) async* {
    yield AuthState.loading(
      usernameController: usernameController,
      passwordController: passwordController,
    );

    final result = await _authManager.auth(
      usernameController.text,
      passwordController.text,
    );

    yield result.fold(
      () => AuthState.autheticated(
        usernameController: usernameController,
        passwordController: passwordController,
      ),
      (r) {
        passwordController.clear();
        Get.snackbar(Strings.error.get(), r.toString());
        return AuthState.error(
          usernameController: usernameController,
          passwordController: passwordController,
          failure: r,
        );
      },
    );
  }

  Stream<AuthState> _register(
    TextEditingController usernameController,
    TextEditingController passwordController, [
    Failure? failure,
  ]) async* {
    yield AuthState.loading(
      usernameController: usernameController,
      passwordController: passwordController,
    );

    final result = await _authManager.register(
      usernameController.text,
      passwordController.text,
    );

    yield result.fold(
      () => AuthState.autheticated(
        usernameController: usernameController,
        passwordController: passwordController,
      ),
      (r) {
        passwordController.clear();
        Get.snackbar(Strings.error.get(), r.toString());
        return AuthState.error(
          usernameController: usernameController,
          passwordController: passwordController,
          failure: r,
        );
      },
    );
  }

  @override
  Stream<Transition<AuthEvent, AuthState>> transformEvents(
    Stream<AuthEvent> events,
    transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 100))
        .switchMap(transitionFn);
  }
}
