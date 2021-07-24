import 'package:flutter/services.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class PostActionsDialog extends UDialogWidget {
  PostActionsDialog({
    Key? key,
    required this.post,
  }) : super(key: key, title: Strings.actions.get());

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...[
          UserProfile(post.author),
          Divider(),
        ],
        UListTile(
          icon: Icon(Icons.copy),
          child: Text(Strings.copyText.get()),
          onPressed: () => _copy(context),
        )
      ],
    );
  }

  void _copy(BuildContext context) {
    // TODO add display text
    Clipboard.setData(ClipboardData(text: ""));
    Navigator.pop(context);
  }
}
