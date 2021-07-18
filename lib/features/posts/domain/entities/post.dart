import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post.freezed.dart';

@freezed
class Post with _$Post {
  factory Post({
    required String id,
    required String text,
    PostAuthor? author,
    required DateTime creationTime,
    required IVector<PostAuthor> mentionedUsers,
  }) = _Post;
}
