import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post_image.freezed.dart';

@freezed
class PostImage with _$PostImage {
  factory PostImage({
    required String id,
    required String url,
  }) = _PostImage;
}
