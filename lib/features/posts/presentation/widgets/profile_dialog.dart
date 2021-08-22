import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({
    Key? key,
    required this.user,
  }) : super(key: key);

  final PostAuthor user;

  @override
  Widget build(BuildContext context) {
    return UDialog(
      title: localizations.shetter.profile,
      child: UserProfile(user),
    );
  }
}
