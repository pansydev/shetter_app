import 'package:pansy_accounts/domain/domain.dart';
import 'package:pansy_accounts/infrastructure/infrastructure.dart';

extension TokenPairMapper on Fragment$TokenPair {
  TokenPair toEntity() {
    return TokenPair(
      accessToken: AccessTokenMapper.toEntity(accessToken),
      refreshToken: refreshToken,
    );
  }
}
