import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/infrastructure/infrastructure.dart';

extension PostAuthorMapper on Fragment$PostAuthor {
  PostAuthor toEntity() {
    // TODO(exeteres): implement isBot
    return PostAuthor(
      id: id,
      username: username,
      isBot: false,
      totalPosts: posts!.totalCount,
    );
  }
}
