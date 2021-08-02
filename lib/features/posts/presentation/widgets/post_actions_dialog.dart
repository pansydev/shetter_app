import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class PostActionsDialog extends UDialogWidget {
  PostActionsDialog(
    this.post, {
    Key? key,
  }) : super(key: key, title: Strings.actions.get());

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
          child: Text(Strings.copyText.get()),
          onPressed: () => _copy(context),
        ),
        if (post.lastModificationTime != null)
          UListTile(
            icon: Icon(Icons.history),
            child: Text(Strings.changesHistory.get()),
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
