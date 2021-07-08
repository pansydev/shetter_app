import 'package:shetter_app/core/presentation/presentation.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
      title: _buildTitle(context),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildContent(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: post.author?.username ?? Strings.unknownAuthor.get(),
        style: context.textTheme.subtitle2,
        children: [
          TextSpan(
            text: '  •  ' + post.creationTime.toFormatedString(),
            style: context.textTheme.subtitle2?.copyWith(
              fontSize: 13,
              color: context.textTheme.subtitle2?.color?.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return MarkdownBody(
      data: post.text.trim(),
      imageBuilder: _imageBuilder,
      styleSheet: MarkdownStyleSheet(
        blockquoteDecoration: BoxDecoration(
          color: context.theme.primaryColorDark,
          border: Border.all(
            width: 1,
            color: context.theme.dividerColor,
          ).add(Border(
            left: BorderSide(
              width: 3,
              color: context.theme.dividerColor,
            ),
          )),
        ),
        blockquotePadding: DesignConstants.padding,
        horizontalRuleDecoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: context.theme.dividerColor,
          ),
        ),
      ),
      onTapLink: _onTapLink,
    );
  }

  Widget _imageBuilder(uri, _, __) {
    return Image.network(
      uri.toString(),
      errorBuilder: (_, __, ___) => Opacity(
        opacity: 0.5,
        child: UChip.outline(
          style: UChipStyle(margin: EdgeInsets.only(top: 10)),
          child: Text(Strings.unsupportedAttachment.get()),
        ),
      ),
    );
  }

  Future<void> _onTapLink(_, url, __) async {
    await launch(url);
  }
}
