import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class UserProfile extends StatelessWidget {
  const UserProfile(
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
        Text(
          Strings.totalPosts.get(author.totalPosts.toString()),
          style: context.textTheme.caption,
        ),
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
