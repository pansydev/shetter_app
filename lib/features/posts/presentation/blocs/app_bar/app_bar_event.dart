import 'package:shetter_app/features/posts/domain/domain.dart';

part 'app_bar_event.freezed.dart';

@freezed
class AppBarEvent with _$AppBarEvent {
  factory AppBarEvent.authenticationStateChanged(AuthenticationState state) =
      AppBarEventAuthenticationStateChanged;
}
