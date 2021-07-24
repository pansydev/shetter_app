import 'package:shetter_app/features/posts/domain/domain.dart';

part 'plain_text_token.freezed.dart';

@freezed
class PlainTextToken with _$PlainTextToken implements TextToken {
  factory PlainTextToken({
    required String text,
  }) = _PlainTextToken;
}
