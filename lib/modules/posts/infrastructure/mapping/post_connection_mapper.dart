import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/infrastructure/infrastructure.dart';

extension PostConnectionMapper on Query$Posts$posts {
  Connection<Post> toEntity() {
    return Connection(
      nodes: UnmodifiableListView(nodes!.map((e) => e.toEntity())),
      pageInfo: pageInfo.toEntity(),
    );
  }
}
