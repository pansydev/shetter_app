import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostAuthorMapper on FragmentPostAuthor {
  PostAuthor toEntity() {
    // TODO implement isBot and totalPosts
    return PostAuthor(
      id: id,
      username: username,
      isBot: false,
      totalPosts: 0,
    );
  }
}
