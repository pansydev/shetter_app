import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/infrastructure/infrastructure.dart';

extension PostVersionMapper on Fragment$PostVersion {
  PostVersion toEntity() {
    return PostVersion(
      creationTime: DateTime.parse(creationTime),
      originalText: originalText,
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
