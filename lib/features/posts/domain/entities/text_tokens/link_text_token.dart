import 'package:shetter_app/features/posts/domain/domain.dart';

part 'link_text_token.freezed.dart';

@freezed
class LinkTextToken with _$LinkTextToken implements TextToken {
  factory LinkTextToken({
    required String text,
    required String url,
  }) = _LinkTextToken;
}
