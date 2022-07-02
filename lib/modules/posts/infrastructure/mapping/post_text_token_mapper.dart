import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/infrastructure/infrastructure.dart';

extension PostTextTokenMapper on Fragment$TextToken {
  TextToken toEntity() {
    final textToken = this;

    if (textToken is Fragment$TextToken$$LinkTextToken) {
      return LinkTextToken(text: text, url: textToken.url);
    }

    if (textToken is Fragment$TextToken$$MentionTextToken) {
      return MentionTextToken(text: text, authorId: textToken.authorId);
    }

    if (textToken is Fragment$TextToken$$PlainTextToken) {
      return PlainTextToken(
        text: text,
        modifiers: textToken.modifiers.toEntitiesList(),
      );
    }

    return UnsupportedTextToken(text: text);
  }
}
