import 'package:shetter_app/core/domain/domain.dart';
import 'package:shetter_app/core/infrastructure/infrastructure.dart';

extension PageInfoMapper on Fragment$PageInfo {
  PageInfo toEntity() {
    return PageInfo(
      hasNextPage: hasNextPage,
      hasPreviousPage: hasPreviousPage,
      startCursor: startCursor,
      endCursor: endCursor,
    );
  }
}
