import 'package:pansy_accounts/domain/domain.dart';

part 'access_token_payload.freezed.dart';

@freezed
class AccessTokenPayload with _$AccessTokenPayload {
  factory AccessTokenPayload({
    required String sessionId,
    required String userId,
    required String username,
    required DateTime expirationTime,
  }) = _AccessTokenPayload;
}
