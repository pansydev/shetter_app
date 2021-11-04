import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostLikeConnectionMapper on QueryPostLikes$post$likes {
  Connection<PostLike> toEntity() {
    return Connection(
      nodes: UnmodifiableListView(nodes!.map((e) => e.toEntity())),
      pageInfo: pageInfo.toEntity(),
    );
  }
}
