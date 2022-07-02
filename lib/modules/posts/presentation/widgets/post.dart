import 'package:flutter/gestures.dart';
import 'package:shetter_app/modules/posts/presentation/presentation.dart';
import 'package:shetter_app/modules/posts/domain/domain.dart';
import 'package:url_launcher/url_launcher.dart';

const double uPostMinHeight = 80;
const double uPostMaxHeight = 300;

class UPost extends StatelessWidget {
  const UPost(
    this.post, {
    Key? key,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final version = post.currentVersion;

    return UCard(
      style: const UCardStyle(
          constraints: BoxConstraints(maxHeight: uPostMaxHeight)),
      trailing: UIconButton(
        // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
        const Icon(Icons.more_vert, size: 16),
        onPressed: () => UDialog.show(context, PostActionsDialog(post)),
      ),
      title: _PostTitle(
        author: post.author,
        creationTime: post.creationTime,
        lastModificationTime: post.lastModificationTime,
      ),
      children: [
        if (version.textTokens.isNotEmpty)
          _PostText(post.currentVersion).sliverBox,
        if (version.images.isNotEmpty)
          _PostImages(version.images).sliverBox.sliverPaddingZero,
      ],
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
      style: const UCardStyle(
          constraints: BoxConstraints(maxHeight: uPostMaxHeight)),
      title: _PostTitle(
        author: author,
        creationTime: version.creationTime,
      ),
      children: [
        if (version.textTokens.isNotEmpty) _PostText(version).sliverBox,
        if (version.images.isNotEmpty)
          _PostImages(version.images).sliverBox.sliverPaddingZero,
      ],
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
          TextSpan(text: author.username),
          if (author.isBot)
            WidgetSpan(
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
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
            text: '  •  ${creationTime.toFormattedString()}',
            style: context.textTheme.subtitle2?.copyWith(
              // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
              fontSize: 13,
              color: context.textTheme.subtitle2?.color?.withOpacity(0.5),
            ),
          ),
          if (lastModificationTime != null)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Icon(
                  // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
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

class _PostText extends StatelessWidget {
  const _PostText(
    this.version, {
    Key? key,
  }) : super(key: key);

  final PostVersion version;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
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
      },
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
  TextStyle _getTextStyle(TextTokenModifier modifier) {
    switch (modifier) {
      case TextTokenModifier.bold:
        return const TextStyle(fontWeight: FontWeight.bold);

      case TextTokenModifier.italic:
        return const TextStyle(fontStyle: FontStyle.italic);

      case TextTokenModifier.underline:
        return const TextStyle(decoration: TextDecoration.underline);

      case TextTokenModifier.strikethrough:
        return const TextStyle(decoration: TextDecoration.lineThrough);

      case TextTokenModifier.code:
        return context.textTheme.overline!.copyWith(
          // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
          fontSize: 12,
          backgroundColor: context.theme.scaffoldBackgroundColor,
        );

      case TextTokenModifier.unsupported:
        return const TextStyle();
    }
  }

  var textStyle = const TextStyle();

  for (final modifier in modifiers) {
    textStyle = textStyle.merge(_getTextStyle(modifier));
  }

  return textStyle;
}

InlineSpan _linkTextSpan(
  BuildContext context,
  LinkTextToken textToken,
) {
  void _onTap() {
    launchUrl(Uri.parse(textToken.url));
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
  // TODO(cirnok): Add opening profile, https://github.com/pansydev/shetter_app/issues/30
  void _onTap() {
    return;
  }

  final isMe = authState.when(
    authenticated: (userInfo) => '@${userInfo.username}' == textToken.text,
    unauthenticated: () => false,
  );
  return WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 2),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
      margin: const EdgeInsets.only(right: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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

class _PostImages extends StatelessWidget {
  const _PostImages(
    this.images, {
    Key? key,
  }) : super(key: key);

  final UnmodifiableListView<PostImage> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80 + 15 * 2,
      child: ListView.separated(
        padding: DesignConstants.padding,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => _PostImagesItem(images, index),
        separatorBuilder: (_, __) => const SizedBox(width: 5),
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
