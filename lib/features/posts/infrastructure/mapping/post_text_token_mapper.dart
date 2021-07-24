import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostTextTokenMapper on FragmentTextToken {
  TextToken toEntity() {
    final textToken = this;

    if (textToken is FragmentTextToken$LinkTextToken) {
      return LinkTextToken(text: text, url: textToken.url);
    }

    if (textToken is FragmentTextToken$MentionTextToken) {
      return MentionTextToken(text: text, authorId: textToken.authorId);
    }

    if (textToken is FragmentTextToken$PlainTextToken) {
      return PlainTextToken(text: text);
    }

    return UnsupportedTextToken(text: text);
  }
}
