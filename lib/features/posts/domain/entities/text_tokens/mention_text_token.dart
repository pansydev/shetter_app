import 'package:shetter_app/features/posts/domain/domain.dart';

part 'mention_text_token.freezed.dart';

@freezed
class MentionTextToken with _$MentionTextToken implements TextToken {
  factory MentionTextToken({
    required String text,
    required String authorId,
  }) = _MentionTextToken;
}
