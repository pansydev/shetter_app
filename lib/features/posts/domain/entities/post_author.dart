import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post_author.freezed.dart';

@freezed
class PostAuthor with _$PostAuthor {
  factory PostAuthor({
    required String id,
    required String username,
    required bool isBot,
    required int totalPosts,
  }) = _PostAuthor;
}
