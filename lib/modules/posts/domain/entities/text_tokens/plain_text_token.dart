import 'package:shetter_app/modules/posts/domain/domain.dart';

part 'plain_text_token.freezed.dart';

@freezed
class PlainTextToken with _$PlainTextToken implements TextToken {
  factory PlainTextToken({
    required String text,
    required UnmodifiableListView<TextTokenModifier> modifiers,
  }) = _PlainTextToken;
}
