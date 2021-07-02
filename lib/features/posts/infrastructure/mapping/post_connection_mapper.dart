import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostConnectionMapper on QueryPosts$posts {
  Connection<Post> toEntity() {
    return Connection(
      nodes: IVector.from(nodes!.map((e) => e.toEntity())),
      pageInfo: pageInfo.toEntity(),
    );
  }
}
