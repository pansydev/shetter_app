import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:url_launcher/url_launcher.dart';

class UPost extends StatelessWidget {
  const UPost(
    this.post, {
    required this.authState,
    Key? key,
  }) : super(key: key);

  final Post post;
  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    return UCard(
      onLongPress: context.isDesktop
          ? null
          : () => PostActionsDialog(post: post).show(context),
      trailing: !context.isDesktop
          ? null
          : UIconButton(
              Icon(Icons.more_vert, size: 20),
              onPressed: () => PostActionsDialog(post: post).show(context),
            ),
      title: _UPostTitle(post),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_UPostContent(post, authState: authState)],
      ),
    );
  }
}

class _UPostTitle extends StatelessWidget {
  const _UPostTitle(
    this.post, {
    Key? key,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: post.author.username,
        style: context.textTheme.subtitle2,
        children: [
          if (post.author.isBot)
            WidgetSpan(
                child: Container(
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
              decoration: BoxDecoration(
                color: context.theme.accentColor.withOpacity(0.6),
                borderRadius: DesignConstants.borderRadiusCircle,
              ),
              child: Text(
                'bot',
                style: context.textTheme.bodyText1!.copyWith(fontSize: 10),
              ),
            )),
          TextSpan(
            text: '  •  ' + post.creationTime.toFormattedString(),
            style: context.textTheme.subtitle2?.copyWith(
              fontSize: 13,
              color: context.textTheme.subtitle2?.color?.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _UPostContent extends StatelessWidget {
  const _UPostContent(
    this.post, {
    required this.authState,
    Key? key,
  }) : super(key: key);

  final Post post;
  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    return ParsedText(
      text: post.currentVersion.textTokens.map((e) => e.text).join(),
      textScaleFactor: context.textScaleFactor,
      style: context.textTheme.bodyText2,
    );
  }

  Future<void> _onTapLink(url) async {
    await launch(url);
  }
}

class _UserMention extends StatelessWidget {
  const _UserMention(
    this.user, {
    required this.isMe,
    Key? key,
  }) : super(key: key);

  final PostAuthor user;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ProfileDialog(user: user).show(context),
      child: Container(
        margin: EdgeInsets.only(right: 2),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: !isMe ? context.theme.primaryColor : context.theme.accentColor,
          borderRadius: DesignConstants.borderRadiusCircle,
          border: Border.all(color: context.theme.dividerColor),
        ),
        child: Text("@${user.username}", style: context.textTheme.bodyText1),
      ),
    );
  }
}
