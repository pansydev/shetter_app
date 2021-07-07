import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

@injectable
class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  AppBarBloc(
    this._stateManager,
  ) : super(_mapAuthenticationState(_stateManager.state)) {
    _stateManager
        .subscribe()
        .listen((event) => add(AppBarEvent.authenticationStateChanged(event)));
  }

  final AuthenticationStateManager _stateManager;

  @override
  Stream<AppBarState> mapEventToState(AppBarEvent event) async* {
    yield _mapAuthenticationState(event.state);
  }

  static AppBarState _mapAuthenticationState(AuthenticationState state) {
    return state.authenticated
        ? AppBarState.authenticated(userInfo: state.userInfo!)
        : AppBarState.unauthenticated();
  }

  void logout() async {
    _stateManager.logout();
  }
}
