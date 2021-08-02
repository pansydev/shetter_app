import 'package:flutter/gestures.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:url_launcher/url_launcher.dart';

class UPost extends StatelessWidget {
  const UPost(
    this.post, {
    Key? key,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return UCard(
      onLongPress: context.isDesktop
          ? null
          : () => PostActionsDialog(post).show(context),
      trailing: !context.isDesktop
          ? null
          : UIconButton(
              Icon(Icons.more_vert, size: 20),
              onPressed: () => PostActionsDialog(post).show(context),
            ),
      title: _PostTitle(
        author: post.author,
        creationTime: post.creationTime,
        lastModificationTime: post.lastModificationTime,
      ),
      child: _PostInfo(
        post.currentVersion,
      ),
    );
  }
}

class UPostVersion extends StatelessWidget {
  const UPostVersion(
    this.version, {
    Key? key,
    required this.author,
  }) : super(key: key);

  final PostVersion version;
  final PostAuthor author;

  @override
  Widget build(BuildContext context) {
    return UCard.outline(
      title: _PostTitle(
        author: author,
        creationTime: version.creationTime,
      ),
      child: _PostInfo(
        version,
      ),
    );
  }
}

class _PostInfo extends StatelessWidget {
  const _PostInfo(
    this.version, {
    Key? key,
  }) : super(key: key);

  final PostVersion version;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PostContent(version, authState: state),
          ],
        );
      },
    );
  }
}

class _PostTitle extends StatelessWidget {
  const _PostTitle({
    Key? key,
    required this.author,
    required this.creationTime,
    this.lastModificationTime,
  }) : super(key: key);

  final PostAuthor author;
  final DateTime creationTime;
  final DateTime? lastModificationTime;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: author.username,
        style: context.textTheme.subtitle2,
        children: [
          if (author.isBot)
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
              ),
            ),
          TextSpan(
            text: '  •  ' + creationTime.toFormattedString(),
            style: context.textTheme.subtitle2?.copyWith(
              fontSize: 13,
              color: context.textTheme.subtitle2?.color?.withOpacity(0.5),
            ),
          ),
          if (lastModificationTime != null)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: EdgeInsets.only(left: 7),
                child: Icon(
                  Icons.edit,
                  size: 12,
                  color: context.textTheme.subtitle2?.color?.withOpacity(0.8),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PostContent extends StatelessWidget {
  const _PostContent(
    this.version, {
    Key? key,
    required this.authState,
  }) : super(key: key);

  final PostVersion version;
  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    final widgets = version.textTokens
        .map((e) => _textTokenToSpan(
              context,
              textToken: e,
              authState: authState,
            ))
        .toList();

    return RichText(
      text: TextSpan(
        style: context.textTheme.bodyText2,
        children: widgets,
      ),
      textScaleFactor: context.textScaleFactor,
    );
  }

  InlineSpan _textTokenToSpan(
    BuildContext context, {
    required TextToken textToken,
    required AuthState authState,
  }) {
    if (textToken is LinkTextToken) {
      return _linkTextSpan(context, text: textToken.text, url: textToken.url);
    }

    if (textToken is MentionTextToken) {
      return _mentionTextSpan(
        context,
        text: textToken.text,
        authState: authState,
      );
    }

    if (textToken is PlainTextToken) {
      return TextSpan(text: textToken.text);
    }

    return _unsupportedTextSpan(context);
  }
}

InlineSpan _linkTextSpan(
  BuildContext context, {
  required String text,
  required String url,
}) {
  void _onTap() {
    launch(url);
  }

  return TextSpan(
    style: TextStyle(
      color: context.theme.accentColor,
    ),
    recognizer: TapGestureRecognizer()..onTap = _onTap,
  );
}

InlineSpan _mentionTextSpan(
  BuildContext context, {
  required String text,
  required AuthState authState,
}) {
  //TODO: Add opening profile
  void _onTap() {}

  final isMe = authState.when(
    authenticated: (userInfo) => "@${userInfo.username}" == text,
    unauthenticated: () => false,
  );
  return WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.only(right: 2),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: !isMe ? context.theme.primaryColor : context.theme.accentColor,
          borderRadius: DesignConstants.borderRadiusCircle,
          border: Border.all(color: context.theme.dividerColor),
        ),
        child: Text(text, style: context.textTheme.bodyText1),
      ),
    ),
  );
}

InlineSpan _unsupportedTextSpan(BuildContext context) {
  return WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: DesignConstants.borderRadiusCircle,
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: Text(
        Strings.unsupportedAttachment.get(),
        style: context.textTheme.bodyText1,
      ),
    ),
  );
}
