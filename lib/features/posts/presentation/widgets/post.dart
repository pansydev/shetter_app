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
            if (version.textTokens.isNotEmpty)
              _PostContent(version, authState: state),
            _PostImagesFragment(version.images),
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
        style: context.textTheme.subtitle2,
        children: [
          TextSpan(
            text: author.username,
          ),
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
    print(version.textTokens);
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
      return _linkTextSpan(context, textToken);
    }

    if (textToken is MentionTextToken) {
      return _mentionTextSpan(
        context,
        textToken,
        authState: authState,
      );
    }

    if (textToken is PlainTextToken) {
      return _plainTextSpan(context, textToken);
    }

    return _unsupportedTextSpan(context);
  }
}

InlineSpan _plainTextSpan(BuildContext context, PlainTextToken textToken) {
  return TextSpan(
    text: textToken.text,
    style: context.textTheme.bodyText2?.merge(
      _generateTextStyle(context, textToken.modifiers),
    ),
  );
}

TextStyle _generateTextStyle(
  BuildContext context,
  List<TextTokenModifier> modifiers,
) {
  var textStyle = TextStyle();

  for (final modifier in modifiers) {
    if (modifier == TextTokenModifier.bold)
      textStyle = textStyle.merge(TextStyle(fontWeight: FontWeight.bold));

    if (modifier == TextTokenModifier.italic)
      textStyle = textStyle.merge(TextStyle(fontStyle: FontStyle.italic));

    if (modifier == TextTokenModifier.underline)
      textStyle = textStyle.merge(TextStyle(
        decoration: TextDecoration.underline,
      ));

    if (modifier == TextTokenModifier.strikethrough)
      textStyle = textStyle.merge(TextStyle(
        decoration: TextDecoration.lineThrough,
      ));

    if (modifier == TextTokenModifier.code)
      textStyle = textStyle.merge(
        context.textTheme.overline!.copyWith(
          fontSize: 12,
          backgroundColor: context.theme.scaffoldBackgroundColor,
        ),
      );
  }

  return textStyle;
}

InlineSpan _linkTextSpan(
  BuildContext context,
  LinkTextToken textToken,
) {
  void _onTap() {
    launch(textToken.url);
  }

  return TextSpan(
    text: textToken.text,
    style: context.textTheme.bodyText2!.copyWith(
      decoration: TextDecoration.underline,
      color: context.theme.indicatorColor,
    ),
    recognizer: TapGestureRecognizer()..onTap = _onTap,
  );
}

InlineSpan _mentionTextSpan(
  BuildContext context,
  MentionTextToken textToken, {
  required AuthState authState,
}) {
  //TODO: Add opening profile
  void _onTap() {}

  final isMe = authState.when(
    authenticated: (userInfo) => "@${userInfo.username}" == textToken.text,
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
        child: Text(textToken.text, style: context.textTheme.bodyText1),
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
        localizations.shetter.unsupported_attachment,
        style: context.textTheme.bodyText1,
      ),
    ),
  );
}

class _PostImagesFragment extends StatelessWidget {
  const _PostImagesFragment(
    this.images, {
    Key? key,
  }) : super(key: key);

  final UnmodifiableListView<PostImage> images;

  @override
  Widget build(BuildContext context) {
    return UAnimatedVisibility(
      visible: images.isNotEmpty,
      child: Column(
        children: [
          SizedBox(height: 10),
          _PostImages(images),
        ],
      ),
    );
  }
}

class _PostImages extends StatelessWidget {
  const _PostImages(
    this.images, {
    Key? key,
  }) : super(key: key);

  final UnmodifiableListView<PostImage> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => _PostImagesItem(images, index),
        separatorBuilder: (_, __) => SizedBox(width: 5),
        itemCount: images.length,
      ),
    );
  }
}

class _PostImagesItem extends StatelessWidget {
  const _PostImagesItem(
    this.images,
    this.index, {
    Key? key,
  }) : super(key: key);

  final UnmodifiableListView<PostImage> images;
  final int index;

  @override
  Widget build(BuildContext context) {
    final image = images[index];
    return UImage(
      UNetworkImageProvider(
        image.url,
        blurHash: image.blurHash,
        showPreloader: true,
      ),
      width: 80,
      height: 80,
      hero: true,
      galleryImages: images.map((e) => UNetworkImageProvider(e.url)).toList(),
    );
  }
}
