import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/presentation/presentation.dart';

@injectable
class AuthDialogBloc extends Bloc<AuthDialogEvent, AuthDialogState> {
  AuthDialogBloc(this._authManager)
      : super(AuthDialogState.initial(
          usernameController: TextEditingController(),
          passwordController: TextEditingController(),
        ));

  final AuthManager _authManager;

  @override
  Stream<AuthDialogState> mapEventToState(AuthDialogEvent event) {
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

  void auth(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (state is AuthDialogStateLoading) return;
    add(AuthDialogEvent.authetication());
  }

  void register(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (state is AuthDialogStateLoading) return;
    add(AuthDialogEvent.registration());
  }

  Stream<AuthDialogState> _auth(
    TextEditingController usernameController,
    TextEditingController passwordController, [
    Failure? failure,
  ]) async* {
    yield AuthDialogState.loading(
      usernameController: usernameController,
      passwordController: passwordController,
    );

    final result = await _authManager.auth(
      usernameController.text,
      passwordController.text,
    );

    yield result.match(
      (l) {
        passwordController.clear();
        return AuthDialogState.error(
          usernameController: usernameController,
          passwordController: passwordController,
          failure: l,
        );
      },
      () {
        usernameController.clear();
        passwordController.clear();
        return AuthDialogState.initial(
          usernameController: usernameController,
          passwordController: passwordController,
        );
      },
    );
  }

  Stream<AuthDialogState> _register(
    TextEditingController usernameController,
    TextEditingController passwordController, [
    Failure? failure,
  ]) async* {
    yield AuthDialogState.loading(
      usernameController: usernameController,
      passwordController: passwordController,
    );

    final result = await _authManager.register(
      usernameController.text,
      passwordController.text,
    );

    yield result.match(
      (l) {
        passwordController.clear();
        return AuthDialogState.error(
          usernameController: usernameController,
          passwordController: passwordController,
          failure: l,
        );
      },
      () {
        usernameController.clear();
        passwordController.clear();
        return AuthDialogState.initial(
          usernameController: usernameController,
          passwordController: passwordController,
        );
      },
    );
  }

  @override
  Stream<Transition<AuthDialogEvent, AuthDialogState>> transformEvents(
    Stream<AuthDialogEvent> events,
    transitionFn,
  ) {
    return events
        .debounceTime(Duration(milliseconds: 100))
        .switchMap(transitionFn);
  }
}
