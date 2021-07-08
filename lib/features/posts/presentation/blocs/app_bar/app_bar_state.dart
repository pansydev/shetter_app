import 'package:shetter_app/features/posts/domain/domain.dart';

part 'app_bar_state.freezed.dart';

@freezed
class AppBarState with _$AppBarState {
  factory AppBarState.authenticated({
    required UserInfo userInfo,
  }) = AppBarStateAuthenticated;

  factory AppBarState.unauthenticated() = AppBarStateUnauthenticated;
}
