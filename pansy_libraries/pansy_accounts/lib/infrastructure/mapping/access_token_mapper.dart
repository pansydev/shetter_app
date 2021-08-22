import 'dart:convert';

import 'package:pansy_accounts/domain/domain.dart';

abstract class AccessTokenMapper {
  static AccessToken toEntity(String accessToken) {
    final normalizedToken = base64.normalize(accessToken.split('.')[1]);
    final payloadJson = utf8.decode(base64.decode(normalizedToken));

    final payload = json.decode(payloadJson);

    return AccessToken(
      value: accessToken,
      payload: AccessTokenPayload(
        sessionId: payload['sid'],
        userId: payload['uid'],
        username: payload['username'],
        expirationTime:
            DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000),
      ),
    );
  }
}
