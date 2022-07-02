import 'package:pansy_arch_graphql/domain/domain.dart';

part 'page_info.freezed.dart';

@freezed
class PageInfo with _$PageInfo {
  factory PageInfo({
    required bool hasNextPage,
    required bool hasPreviousPage,
    String? startCursor,
    String? endCursor,
  }) = _PageInfo;
}
