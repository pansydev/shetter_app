import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post.freezed.dart';

@freezed
class Post with _$Post {
  factory Post({
    required String id,
    required PostAuthor author,
    required DateTime creationTime,
    required DateTime? lastModificationTime,
    required PostVersion currentVersion,
    required PostLikes likes,
  }) = _Post;
}
