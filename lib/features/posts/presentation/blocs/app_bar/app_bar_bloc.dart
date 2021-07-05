import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

@injectable
class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  AppBarBloc(
    AuthenticationStateProvider stateProvider,
  ) : super(_mapAuthenticationState(stateProvider.state)) {
    stateProvider
        .subscribe()
        .listen((event) => add(AppBarEvent.authenticationStateChanged(event)));
  }

  @override
  Stream<AppBarState> mapEventToState(AppBarEvent event) async* {
    yield _mapAuthenticationState(event.state);
  }

  static AppBarState _mapAuthenticationState(AuthenticationState state) {
    return state.authenticated
        ? AppBarState.authenticated(userInfo: state.userInfo!)
        : AppBarState.unauthenticated();
  }
}