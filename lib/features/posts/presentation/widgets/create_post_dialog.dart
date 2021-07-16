import 'package:shetter_app/features/posts/presentation/presentation.dart';

class CreatePostDialog extends UDialogWidget {
  CreatePostDialog({Key? key})
      : super(key: key, title: Strings.postFormAction.get());

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<PostFormBloc, PostFormState>(
      builder: (context, state) {
        return UFrameLoader(
          state: state.maybeMap(
            loading: (_) => UFrameLoaderState.loading(),
            orElse: () => UFrameLoaderState.initial(),
          ),
          child: Column(
            children: [
              UTextField(
                controller: state.textController,
                hintText: Strings.writeAMessage.get(),
                minLines: 5,
                maxLines: 10,
                autofocus: true,
              ),
              SizedBox(height: DesignConstants.paddingMiniValue),
              _CreatePostDialogToolbar(),
            ],
          ),
        );
      },
    );
  }
}

class _CreatePostDialogToolbar extends StatelessWidget {
  const _CreatePostDialogToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: context.theme.iconTheme.copyWith(size: 22),
      child: Row(
        children: [
          Spacer(),
          UIconButton(
            Icon(Icons.send_rounded),
            onPressed: () => _createPost(context),
          ),
        ],
      ),
    );
  }

  void _createPost(BuildContext context) async {
    if (await context.read<PostFormBloc>().createPost()) {
      Navigator.pop(context);
    }
  }
}
