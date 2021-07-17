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
        if (post.author != null) ...[
          _UserProfile(post.author!),
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
    Clipboard.setData(ClipboardData(text: post.text));
    Navigator.pop(context);
  }
}

class _UserProfile extends StatelessWidget {
  const _UserProfile(
    this.author, {
    Key? key,
  }) : super(key: key);

  final PostAuthor author;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 15),
      child: Row(
        children: [
          CircleAvatar(
            child: Text(
              author.username.substring(0, 2).toUpperCase(),
              style: context.textTheme.bodyText1,
            ),
          ),
          SizedBox(width: 8),
          Expanded(child: _UserProfileUsername(author)),
        ],
      ),
    );
  }
}

class _UserProfileUsername extends StatelessWidget {
  const _UserProfileUsername(
    this.author, {
    Key? key,
  }) : super(key: key);

  final PostAuthor author;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CopytableText(
          author.username,
          style: context.textTheme.bodyText1,
        ),
        SizedBox(height: 3),
        _CopytableText(
          author.id,
          style: context.textTheme.overline,
        )
      ],
    );
  }
}

class _CopytableText extends StatelessWidget {
  const _CopytableText(
    this.data, {
    Key? key,
    this.style,
  }) : super(key: key);

  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return UPressable(
      showBorder: true,
      onLongPress: () => Clipboard.setData(ClipboardData(text: data)),
      child: Text(
        data,
        style: style,
      ),
    );
  }
}
