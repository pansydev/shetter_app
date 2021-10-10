import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post_likes.freezed.dart';

@freezed
class PostLikes with _$PostLikes {
  factory PostLikes({
    required bool isLiked,
    required int count,
  }) = _PostLikes;
}
