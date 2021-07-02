import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_input.freezed.dart';

@freezed
class PostInput with _$PostInput {
  factory PostInput({
    required String text,
  }) = _PostInput;
}
