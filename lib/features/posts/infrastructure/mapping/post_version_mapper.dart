import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostVersionMapper on FragmentPostVersion {
  PostVersion toEntity() {
    return PostVersion(
      creationTime: DateTime.parse(creationTime),
      textTokens: UnmodifiableListView(textTokens.map((e) => e.toEntity())),
      images: UnmodifiableListView(
        images.map(
          (e) => PostImage(
            id: e.id,
            url: e.url,
            blurHash: e.blurHash,
          ),
        ),
      ),
    );
  }
}
