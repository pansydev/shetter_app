import 'package:shetter_app/features/auth/domain/domain.dart';
import 'package:shetter_app/features/auth/infrastructure/infrastructure.dart';

extension TokenPairMapper on FragmentTokenPair {
  TokenPair toEntity() {
    return TokenPair(
      accessToken: AccessTokenMapper.toEntity(accessToken),
      refreshToken: refreshToken,
    );
  }
}
