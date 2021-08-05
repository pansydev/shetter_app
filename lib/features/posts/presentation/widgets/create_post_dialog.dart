import 'package:shetter_app/features/posts/domain/domain.dart';
import 'package:shetter_app/features/posts/presentation/presentation.dart';

class CreatePostDialog extends UDialogWidget {
  CreatePostDialog({Key? key})
      : super(key: key, title: Strings.postFormAction.get());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostFormBloc, PostFormState>(
      builder: (context, state) {
        return UFrameLoader(
          state: state.maybeMap(
            loading: (_) => UFrameLoaderState.loading,
            orElse: () => UFrameLoaderState.initial,
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
              _CreatePostDialogImagesAdapter(state),
              _CreatePostDialogToolbar(),
            ],
          ),
        );
      },
    );
  }
}

class _CreatePostDialogImagesAdapter extends StatelessWidget {
  const _CreatePostDialogImagesAdapter(
    this.state, {
    Key? key,
  }) : super(key: key);

  final PostFormState state;

  @override
  Widget build(BuildContext context) {
    return UAnimatedVisibility(
      visible: state.images.isNotEmpty,
      child: Column(
        children: [
          _CreatePostDialogImages(state.images),
          SizedBox(height: DesignConstants.paddingMiniValue),
        ],
      ),
    );
  }
}

class _CreatePostDialogImages extends StatelessWidget {
  const _CreatePostDialogImages(
    this.images, {
    Key? key,
  }) : super(key: key);

  final UnmodifiableListView<File> images;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 80),
      child: ReorderableListView.builder(
        scrollDirection: Axis.horizontal,
        proxyDecorator: (child, _, animation) {
          return ScaleTransition(
            scale: animation.drive(
              1.0.tweenTo(0.8).curved(Curves.easeInOutCubic),
            ),
            child: child,
          );
        },
        itemBuilder: (_, index) {
          if (index == 0) {
            return _CreatePostDialogImagesItem(
              images[index],
              key: ValueKey(images[index]),
            );
          }

          return Row(
            key: ValueKey(images[index]),
            children: [
              SizedBox(width: 5),
              _CreatePostDialogImagesItem(
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

class _CreatePostDialogImagesItem extends StatelessWidget {
  const _CreatePostDialogImagesItem(
    this.image, {
    Key? key,
  }) : super(key: key);

  final File image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        UCard.outline(
          style: UCardStyle(padding: EdgeInsets.zero),
          clipBehavior: Clip.antiAlias,
          child: Image.file(
            image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        UChip.outline(
          style: UChipStyle(
            padding: DesignConstants.padding5,
            margin: DesignConstants.padding5,
          ),
          child: Icon(
            Icons.close,
            size: 15,
          ),
          onPressed: () => removeImage(context),
        ),
      ],
    );
  }

  void removeImage(BuildContext context) {
    context.read<PostFormBloc>().removeImage(image);
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

  void _addPhoto(BuildContext context) {
    context.read<PostFormBloc>().addImage();
  }

  void _addPhotoFromCamera(BuildContext context) {
    context.read<PostFormBloc>().addImage(fromCamera: true);
  }
}
