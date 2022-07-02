import 'package:shetter_app/modules/posts/presentation/presentation.dart';

part 'post_form_event.freezed.dart';

@freezed
class PostFormEvent with _$PostFormEvent {
  const factory PostFormEvent.sendPost() = PostFormEventCreatePost;
  const factory PostFormEvent.update(
    PostEditingController newPostEditingController,
  ) = PostFormEventUpdateImages;
}
