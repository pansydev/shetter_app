import 'package:shetter_app/features/posts/domain/domain.dart';

part 'post_form_event.freezed.dart';

@freezed
class PostFormEvent with _$PostFormEvent {
  const factory PostFormEvent.createPost() = PostFormEventCreatePost;
}
