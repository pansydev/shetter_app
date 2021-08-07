import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class PostActionsDialog extends UDialogWidget {
  PostActionsDialog(
    this.post, {
    Key? key,
  }) : super(key: key, title: localizations.shetter.actions);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...[
          UserProfile(post.author),
          Divider(),
        ],
        UListTile(
          icon: Icon(Icons.copy),
          child: Text(localizations.shetter.copy_text),
          onPressed: () => _copy(context),
        ),
        if (post.lastModificationTime != null)
          UListTile(
            icon: Icon(Icons.history),
            child: Text(localizations.shetter.change_history),
            onPressed: () => PostHistoryDialog(post).show(context),
          ),
      ],
    );
  }

  void _copy(BuildContext context) {
    // TODO add display text
    Clipboard.setData(ClipboardData(text: ""));
    Navigator.pop(context);
  }
}
