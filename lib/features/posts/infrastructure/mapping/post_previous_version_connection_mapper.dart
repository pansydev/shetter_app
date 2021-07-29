import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostPreviousVersionConnectionMapper
    on QueryPostPreviousVersions$post$previousVersions {
  Connection<PostVersion> toEntity() {
    return Connection(
      nodes: UnmodifiableListView(nodes!.map((e) => e.toEntity())),
      pageInfo: pageInfo.toEntity(),
    );
  }
}
