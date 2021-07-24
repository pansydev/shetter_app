import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension PostVersionMapper on FragmentPostVersion {
  PostVersion toEntity() {
    return PostVersion(
      creationTime: DateTime.parse("TODO implement"),
      textTokens: UnmodifiableListView(textTokens.map((e) => e.toEntity())),
    );
  }
}
