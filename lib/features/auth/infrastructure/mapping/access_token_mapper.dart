import 'dart:convert';

import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/infrastructure/infrastructure.dart';

abstract class AccessTokenMapper {
  static AccessToken toEntity(String accessToken) {
    final payloadJson = utf8.decode(base64.decode(
      base64.normalize(accessToken.split(".")[1]),
    ));
    final payload = json.decode(payloadJson);

    return AccessToken(
      value: accessToken,
      payload: AccessTokenPayload(
        sessionId: payload["sid"],
        userId: payload["uid"],
        username: payload["username"],
        expirationTime: DateTimeMapper.unixSecondsToDateTime(payload["exp"]),
      ),
    );
  }
}
