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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...[
              UserProfile(post.author),
              Divider(),
            ],
            if (state is AuthStateAuthenticated &&
                post.author.username == state.userInfo.username)
              UListTile(
                icon: Icon(Icons.edit),
                onPressed: () => PostFormDialog(
                  editablePost: post,
                ).show(context),
                child: Text(localizations.shetter.post_form_edit_action),
              ),
            UListTile(
              icon: Icon(Icons.copy),
              onPressed: () => _copy(context),
              child: Text(localizations.shetter.copy_text),
            ),
            if (post.lastModificationTime != null)
              UListTile(
                icon: Icon(Icons.history),
                onPressed: () => PostHistoryDialog(post).show(context),
                child: Text(localizations.shetter.change_history),
              ),
          ],
        );
      },
    );
  }

  void _copy(BuildContext context) {
    // TODO(exeteres): add display text
    Clipboard.setData(ClipboardData(text: ''));
    Navigator.pop(context);
  }
}
