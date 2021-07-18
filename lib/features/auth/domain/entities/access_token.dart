import 'package:shetter_app/features/auth/domain/domain.dart';

part 'access_token.freezed.dart';

@freezed
class AccessToken with _$AccessToken {
  factory AccessToken({
    required String value,
    required AccessTokenPayload payload,
  }) = _AccessToken;
}
