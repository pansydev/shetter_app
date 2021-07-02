import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostMapper on FragmentPost {
  Post toEntity() {
    return Post(
      id: id,
      text: text,
      author: author?.toEntity(),
      creationTime: DateTimeMapper.unixSecondsToDateTime(creationTime),
      mentionedUsers: IVector.from(mentionedUsers.map((e) => e.toEntity())),
    );
  }
}
