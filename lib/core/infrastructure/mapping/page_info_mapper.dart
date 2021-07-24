import 'package:pansy_arch_graphql/domain/domain.dart';
import 'package:shetter_app/core/infrastructure/infrastructure.dart';

extension PageInfoMapper on FragmentPageInfo {
  PageInfo toEntity() {
    return PageInfo(
      hasNextPage: hasNextPage,
      hasPreviousPage: hasPreviousPage,
      startCursor: startCursor,
      endCursor: endCursor,
    );
  }
}
