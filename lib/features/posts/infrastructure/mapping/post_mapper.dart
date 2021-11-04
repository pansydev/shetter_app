import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostMapper on FragmentPost {
  Post toEntity() {
    return Post(
      id: id,
      author: author.toEntity(),
      creationTime: DateTime.parse(creationTime),
      lastModificationTime: lastModificationTime != null
          ? DateTime.parse(lastModificationTime!)
          : null,
      currentVersion: currentVersion.toEntity(),
      isLiked: isLiked,
      totalLikes: likes!.totalCount,
    );
  }
}
