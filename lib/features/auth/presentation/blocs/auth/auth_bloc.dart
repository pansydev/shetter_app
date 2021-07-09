import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/presentation/presentation.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._stateManager,
  ) : super(_mapAuthenticationState(_stateManager.state)) {
    _stateManager
        .subscribe()
        .listen((event) => add(AuthEvent.authenticationStateChanged(event)));
  }

  final AuthenticationStateManager _stateManager;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    yield _mapAuthenticationState(event.state);
  }

  static AuthState _mapAuthenticationState(AuthenticationState state) {
    return state.authenticated
        ? AuthState.authenticated(userInfo: state.userInfo!)
        : AuthState.unauthenticated();
  }

  void logout() => _stateManager.logout();
}
