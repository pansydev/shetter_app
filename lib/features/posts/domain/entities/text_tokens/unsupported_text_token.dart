import 'package:shetter_app/features/posts/domain/domain.dart';

part 'unsupported_text_token.freezed.dart';

@freezed
class UnsupportedTextToken with _$UnsupportedTextToken implements TextToken {
  factory UnsupportedTextToken({
    required String text,
  }) = _UnsupportedTextToken;
}
