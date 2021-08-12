import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/infrastructure/infrastructure.dart';

extension TextTokenModifierMapper on EnumTextTokenModifier {
  TextTokenModifier toEntity() {
    final tokenModifier = this;

    if (tokenModifier == EnumTextTokenModifier.bold) {
      return TextTokenModifier.bold;
    }

    if (tokenModifier == EnumTextTokenModifier.italic) {
      return TextTokenModifier.italic;
    }

    if (tokenModifier == EnumTextTokenModifier.underline) {
      return TextTokenModifier.underline;
    }

    if (tokenModifier == EnumTextTokenModifier.strikethrough) {
      return TextTokenModifier.strikethrough;
    }

    if (tokenModifier == EnumTextTokenModifier.code) {
      return TextTokenModifier.code;
    }

    return TextTokenModifier.unsupported;
  }
}

extension TextTokenModifiersMapper on List<EnumTextTokenModifier> {
  UnmodifiableListView<TextTokenModifier> toEntitiesList() {
    return UnmodifiableListView(map((e) => e.toEntity()));
  }
}
