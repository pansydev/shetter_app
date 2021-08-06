import 'dart:io';

import 'package:pansy_ui/pansy_ui.dart';

@immutable
class UImageProvider {
  const UImageProvider();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UImageProvider && runtimeType == other.runtimeType;
}

class UNetworkImageProvider extends UImageProvider {
  const UNetworkImageProvider(
    this.url, {
    this.showPreloader = false,
  });

  final String url;
  final bool showPreloader;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UNetworkImageProvider &&
          runtimeType == other.runtimeType &&
          url == other.url;

  @override
  int get hashCode => url.hashCode;
}

class UFileImageProvider extends UImageProvider {
  const UFileImageProvider(this.file);
  final File file;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UFileImageProvider &&
          runtimeType == other.runtimeType &&
          file == other.file;

  @override
  int get hashCode => file.hashCode;
}
