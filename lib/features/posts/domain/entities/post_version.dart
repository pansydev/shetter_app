import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post_version.freezed.dart';

@freezed
class PostVersion with _$PostVersion {
  factory PostVersion({
    required DateTime creationTime,
    required UnmodifiableListView<TextToken> textTokens,
    required UnmodifiableListView<PostImage> images,
  }) = _PostVersion;
}
