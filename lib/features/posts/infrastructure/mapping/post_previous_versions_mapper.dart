import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostPreviousVersionsMapper on QueryPostPreviousVersions$post {
  UnmodifiableListView<PostVersion> toEntity() {
    return UnmodifiableListView(previousVersions.map((e) => e.toEntity()));
  }
}
