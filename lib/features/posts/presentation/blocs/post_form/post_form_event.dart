import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

part 'post_form_event.freezed.dart';

@freezed
class PostFormEvent with _$PostFormEvent {
  const factory PostFormEvent.createPost() = PostFormEventCreatePost;
  const factory PostFormEvent.updateImages(UnmodifiableListView<File> images) =
      PostFormEventUpdateImages;
}
