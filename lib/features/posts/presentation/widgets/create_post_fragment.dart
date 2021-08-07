import 'package:shetter_app/features/posts/presentation/presentation.dart';

class CreatePostFragment extends StatelessWidget {
  const CreatePostFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return UAnimatedVisibility(
          lazySize: false,
          visible: state is AuthStateAuthenticated,
          child: UCard.outline(
            onPressed: () => PostFormDialog().show(context),
            style: UCardStyle(
              margin: EdgeInsets.symmetric(
                horizontal: DesignConstants.paddingValue,
              ).copyWith(top: DesignConstants.paddingMiniValue),
            ),
            child: _CreatePostFragmentBody(),
          ),
        );
      },
    ).sliverBox;
  }
}

class _CreatePostFragmentBody extends StatelessWidget {
  const _CreatePostFragmentBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: SizedBox(
        height: 25,
        child: IconTheme(
          data: context.theme.iconTheme.copyWith(
            size: 22,
          ),
          child: Row(
            children: [
              Text(
                localizations.shetter.write_a_message,
                style: context.textTheme.button,
              ),
              Spacer(),
              Icon(Icons.tag_faces_outlined),
              SizedBox(width: 10),
              Icon(Icons.image_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
