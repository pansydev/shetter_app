import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class ProfileDialog extends UDialogWidget {
  ProfileDialog({
    Key? key,
    required this.user,
  }) : super(key: key, title: Strings.profile.get());

  final PostAuthor user;

  @override
  Widget build(BuildContext context) {
    return UserProfile(user);
  }
}
