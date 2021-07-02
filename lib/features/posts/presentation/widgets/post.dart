import 'package:shetter_app/core/presentation/presentation.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:timeago/timeago.dart' as timeago;

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
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildContent(),
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
            text: '  •  ' + timeago.format(post.creationTime, locale: 'ru'),
            style: context.textTheme.subtitle2?.copyWith(
              fontSize: 13,
              color: context.textTheme.subtitle2?.color?.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return MarkdownBody(data: post.text.trim());
  }
}
