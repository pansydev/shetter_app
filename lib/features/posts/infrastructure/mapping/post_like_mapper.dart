import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostLikeMapper on FragmentPostLike {
  PostLike toEntity() {
    return PostLike(author: author.toEntity());
  }
}
