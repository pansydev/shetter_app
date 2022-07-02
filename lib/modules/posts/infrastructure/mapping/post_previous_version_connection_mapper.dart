import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/infrastructure/infrastructure.dart';

extension PostPreviousVersionConnectionMapper
    on Query$PostPreviousVersions$post$previousVersions {
  Connection<PostVersion> toEntity() {
    return Connection(
      nodes: UnmodifiableListView(nodes!.map((e) => e.toEntity())),
      pageInfo: pageInfo.toEntity(),
    );
  }
}
