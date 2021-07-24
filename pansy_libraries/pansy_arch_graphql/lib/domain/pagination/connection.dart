import 'package:pansy_arch_graphql/domain/domain.dart';

part 'connection.freezed.dart';

@freezed
class Connection<Entity> with _$Connection<Entity> {
  factory Connection({
    required UnmodifiableListView<Entity> nodes,
    required PageInfo pageInfo,
  }) = _Connection;
}
