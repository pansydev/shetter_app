import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/infrastructure/infrastructure.dart';

extension TextTokenModifierMapper on Enum$TextTokenModifier {
  TextTokenModifier toEntity() {
    final tokenModifier = this;

    if (tokenModifier == Enum$TextTokenModifier.BOLD) {
      return TextTokenModifier.bold;
    }

    if (tokenModifier == Enum$TextTokenModifier.ITALIC) {
      return TextTokenModifier.italic;
    }

    if (tokenModifier == Enum$TextTokenModifier.UNDERLINE) {
      return TextTokenModifier.underline;
    }

    if (tokenModifier == Enum$TextTokenModifier.STRIKETHROUGH) {
      return TextTokenModifier.strikethrough;
    }

    if (tokenModifier == Enum$TextTokenModifier.CODE) {
      return TextTokenModifier.code;
    }

    return TextTokenModifier.unsupported;
  }
}

extension TextTokenModifiersMapper on List<Enum$TextTokenModifier> {
  UnmodifiableListView<TextTokenModifier> toEntitiesList() {
    return UnmodifiableListView(map((e) => e.toEntity()));
  }
}
