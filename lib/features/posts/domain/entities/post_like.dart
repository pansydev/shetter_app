import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post_like.freezed.dart';

@freezed
class PostLike with _$PostLike {
  factory PostLike({
    required PostAuthor author,
  }) = _PostLike;
}
