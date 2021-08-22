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

  Future<void> auth(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (state is AuthDialogStateLoading) return;
    add(AuthDialogEvent.authetication());

    await stream.firstWhere((element) => element is! AuthDialogStateLoading);
    if (state is AuthDialogStateInitial) Navigator.pop(context);
  }

  Future<void> register(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (state is AuthDialogStateLoading) return;
    add(AuthDialogEvent.registration());

    await stream.firstWhere((element) => element is! AuthDialogStateLoading);
    if (state is AuthDialogStateInitial) Navigator.pop(context);
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

    yield _applyAuthenticationResult(
      usernameController,
      passwordController,
      result,
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

    yield _applyAuthenticationResult(
      usernameController,
      passwordController,
      result,
    );
  }

  AuthDialogState _applyAuthenticationResult(
    TextEditingController usernameController,
    TextEditingController passwordController,
    Option<Failure> result,
  ) {
    return result.match(
      (l) {
        Fluttertoast.showToast(
          msg: localizations.failureLocalizer.localize(l),
        );
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
