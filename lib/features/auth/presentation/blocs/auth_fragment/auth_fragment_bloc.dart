import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/presentation/presentation.dart';

@injectable
class AuthFragmentBloc extends Bloc<AuthFragmentEvent, AuthFragmentState> {
  AuthFragmentBloc(this._authManager)
      : super(AuthFragmentState.initial(
          usernameController: TextEditingController(),
          passwordController: TextEditingController(),
        ));

  final AuthManager _authManager;

  @override
  Stream<AuthFragmentState> mapEventToState(AuthFragmentEvent event) {
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
    if (state is AuthFragmentStateLoading) return;
    add(AuthFragmentEvent.authetication());
  }

  void register() {
    if (state is AuthFragmentStateLoading) return;
    add(AuthFragmentEvent.registration());
  }

  Stream<AuthFragmentState> _auth(
    TextEditingController usernameController,
    TextEditingController passwordController, [
    Failure? failure,
  ]) async* {
    yield AuthFragmentState.loading(
      usernameController: usernameController,
      passwordController: passwordController,
    );

    final result = await _authManager.auth(
      usernameController.text,
      passwordController.text,
    );

    yield result.fold(
      () => AuthFragmentState.initial(
        usernameController: usernameController,
        passwordController: passwordController,
      ),
      (r) {
        passwordController.clear();
        Get.snackbar(Strings.error.get(), r.toString());
        return AuthFragmentState.error(
          usernameController: usernameController,
          passwordController: passwordController,
          failure: r,
        );
      },
    );
  }

  Stream<AuthFragmentState> _register(
    TextEditingController usernameController,
    TextEditingController passwordController, [
    Failure? failure,
  ]) async* {
    yield AuthFragmentState.loading(
      usernameController: usernameController,
      passwordController: passwordController,
    );

    final result = await _authManager.register(
      usernameController.text,
      passwordController.text,
    );

    yield result.fold(
      () => AuthFragmentState.initial(
        usernameController: usernameController,
        passwordController: passwordController,
      ),
      (r) {
        passwordController.clear();
        Get.snackbar(Strings.error.get(), r.toString());
        return AuthFragmentState.error(
          usernameController: usernameController,
          passwordController: passwordController,
          failure: r,
        );
      },
    );
  }

  @override
  Stream<Transition<AuthFragmentEvent, AuthFragmentState>> transformEvents(
    Stream<AuthFragmentEvent> events,
    transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 100))
        .switchMap(transitionFn);
  }
}
