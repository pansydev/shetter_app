import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_author.freezed.dart';

@freezed
class PostAuthor with _$PostAuthor {
  factory PostAuthor({
    required String id,
    required String username,
    required bool isBot,
  }) = _PostAuthor;
}
