import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:shetter_app/modules/posts/presentation/presentation.dart';

class PostActionsDialog extends StatelessWidget {
  const PostActionsDialog(
    this.post, {
    Key? key,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return UDialog(
      title: localizations.shetter.actions,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserProfile(post.author),
          const Divider(),
          _EditButton(post),
          UListTile(
            icon: const Icon(Icons.copy),
            onPressed: () => _copy(context),
            child: Text(localizations.shetter.copy_text),
          ),
          if (post.lastModificationTime != null)
            UListTile(
              icon: const Icon(Icons.history),
              onPressed: () => UDialog.show(context, PostHistoryDialog(post)),
              child: Text(localizations.shetter.change_history),
            ),
        ],
      ),
    );
  }

  void _copy(BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: post.currentVersion.textTokens.map((e) => e.text).join(),
      ),
    );
    Navigator.pop(context);
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton(
    this.post, {
    Key? key,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => state.maybeWhen(
        authenticated: (userInfo) {
          return Visibility(
            visible: post.author.username == userInfo.username,
            child: UListTile(
              icon: const Icon(Icons.edit),
              onPressed: () => UDialog.show(
                context,
                PostFormDialog(editablePost: post),
              ),
              child: Text(localizations.shetter.post_form_edit_action),
            ),
          );
        },
        orElse: () => const SizedBox(),
      ),
    );
  }
}
