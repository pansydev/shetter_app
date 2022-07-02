import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/infrastructure/infrastructure.dart';

extension PostMapper on Fragment$Post {
  Post toEntity() {
    return Post(
      id: id,
      author: author.toEntity(),
      creationTime: DateTime.parse(creationTime),
      lastModificationTime: lastModificationTime != null
          ? DateTime.parse(lastModificationTime!)
          : null,
      currentVersion: currentVersion.toEntity(),
    );
  }
}
