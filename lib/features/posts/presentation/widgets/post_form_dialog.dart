import 'package:shetter_app/core/infrastructure/infrastructure.dart';
import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class PostFormDialog extends StatelessWidget {
  const PostFormDialog({
    Key? key,
    this.editablePost,
  }) : super(key: key);

  final Post? editablePost;

  @override
  Widget build(BuildContext context) {
    return UDialog(
      title: editablePost != null
          ? localizations.shetter.post_form_edit_action
          : localizations.shetter.post_form_create_action,
      child: _PostFormDialogEditablePostProvider(
        editablePost,
        child: BlocBuilder<PostFormBloc, PostFormState>(
          builder: (context, state) {
            return UFrameLoader(
              state: state.maybeMap(
                loading: (_) => UFrameLoaderState.loading,
                orElse: () => UFrameLoaderState.initial,
              ),
              child: Column(
                children: [
                  UTextField(
                    controller: state.postEditingController.textController,
                    hintText: localizations.shetter.write_a_message,
                    minLines: 5,
                    maxLines: 10,
                    autofocus: true,
                  ),
                  SizedBox(height: DesignConstants.paddingMiniValue),
                  _PostFormDialogImagesAdapter(
                    state.postEditingController.images,
                  ),
                  _PostFormDialogToolbar(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PostFormDialogEditablePostProvider extends StatelessWidget {
  const _PostFormDialogEditablePostProvider(
    this.post, {
    Key? key,
    required this.child,
  }) : super(key: key);

  final Post? post;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (post == null) return child;

    final provider = context.read<ServiceProvider>();
    return BlocProvider<PostFormBloc>(
      create: (_) => provider.createBloc<PostFormBloc>(param1: post),
      child: child,
    );
  }
}

class _PostFormDialogImagesAdapter extends StatelessWidget {
  const _PostFormDialogImagesAdapter(
    this.images, {
    Key? key,
  }) : super(key: key);

  final List<PostEditingImage> images;

  @override
  Widget build(BuildContext context) {
    return UAnimatedVisibility(
      visible: images.isNotEmpty,
      child: Column(
        children: [
          _PostFormDialogImages(images),
          SizedBox(height: DesignConstants.paddingMiniValue),
        ],
      ),
    );
  }
}

class _PostFormDialogImages extends StatelessWidget {
  const _PostFormDialogImages(
    this.images, {
    Key? key,
  }) : super(key: key);

  final List<PostEditingImage> images;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
      constraints: BoxConstraints(maxHeight: 80),
      child: ReorderableListView.builder(
        scrollDirection: Axis.horizontal,
        proxyDecorator: (child, _, animation) {
          return ScaleTransition(
            scale: animation.drive(
              // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
              1.0.tweenTo(0.8).curved(Curves.easeInOutCubic),
            ),
            child: child,
          );
        },
        itemBuilder: (_, index) {
          if (index == 0) {
            return _PostFormDialogImagesItem(
              images[index],
              key: ValueKey(images[index]),
            );
          }

          return Row(
            key: ValueKey(images[index]),
            children: [
              SizedBox(width: 5),
              _PostFormDialogImagesItem(
                images[index],
              ),
            ],
          );
        },
        itemCount: images.length,
        onReorder: context.read<PostFormBloc>().reorderImage,
      ),
    );
  }
}

class _PostFormDialogImagesItem extends StatelessWidget {
  const _PostFormDialogImagesItem(
    this.image, {
    Key? key,
  }) : super(key: key);

  final PostEditingImage image;

  @override
  Widget build(BuildContext context) {
    return UImage(
      image.fileImage != null
          ? UFileImageProvider(image.fileImage!)
          : UNetworkImageProvider(image.networkImage!.url),
      // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
      width: 80,
      height: 80,
      onClose: () => removeImage(context),
    );
  }

  void removeImage(BuildContext context) {
    context.read<PostFormBloc>().removeImage(image);
  }
}

class _PostFormDialogToolbar extends StatelessWidget {
  const _PostFormDialogToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      // TODO(cirnok): magic numbers, https://github.com/pansydev/shetter_app/issues/29
      data: context.theme.iconTheme.copyWith(size: 22),
      child: Row(
        children: [
          UIconButton(
            Icon(Icons.photo_camera_outlined),
            onPressed: () => _addPhotoFromCamera(context),
          ),
          UIconButton(
            Icon(Icons.photo_outlined),
            onPressed: () => _addPhoto(context),
          ),
          Spacer(),
          UIconButton(
            Icon(Icons.send_rounded),
            onPressed: () => _sendPost(context),
          ),
        ],
      ),
    );
  }

  Future<void> _sendPost(BuildContext context) async {
    if (await context.read<PostFormBloc>().sendPost()) {
      Navigator.pop(context);
    }
  }

  void _addPhoto(BuildContext context) {
    context.read<PostFormBloc>().addImage();
  }

  void _addPhotoFromCamera(BuildContext context) {
    context.read<PostFormBloc>().addImage(fromCamera: true);
  }
}
