import 'package:shetter_app/features/auth/domain/domain.dart';

part 'token_pair.freezed.dart';

@freezed
class TokenPair with _$TokenPair {
  factory TokenPair({
    required AccessToken accessToken,
    required String refreshToken,
  }) = _TokenPair;
}
