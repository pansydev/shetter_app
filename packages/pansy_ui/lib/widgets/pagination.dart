import 'package:pansy_ui/pansy_ui.dart';

typedef UPaginateCallback = void Function(int count);

class UPaginate {
  UPaginate({
    required this.minChildHeight,
    required this.onFetchRequest,
    ScrollController? controller,
    bool fetchAtStart = true,
    this.bufferCount = _bufferCount,
    this.requestScrollPosition = _requestScrollPosition,
  }) : this.controller = controller ?? ScrollController() {
    this.controller.addListener(_listener);

    if (fetchAtStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) => fetch());
    }
  }

  final double minChildHeight;
  final UPaginateCallback onFetchRequest;
  final ScrollController controller;
  final int bufferCount;
  final double requestScrollPosition;

  static const int _bufferCount = 20;
  static const double _requestScrollPosition = 500;

  static int getPageSizeWithContext(
    BuildContext context, {
    required double minChildHeight,
    int bufferCount = _bufferCount,
  }) {
    final height = context.height;
    return _calculatePageSize(
      height,
      minChildHeight,
      bufferCount,
    );
  }

  void _listener() {
    if (controller.position.extentAfter <= requestScrollPosition) fetch();
  }

  void fetch() => onFetchRequest(getPageSize());

  int getPageSize() {
    final height = controller.position.viewportDimension;
    return _calculatePageSize(
      height,
      minChildHeight,
      bufferCount,
    );
  }

  static int _calculatePageSize(
    double height,
    double minChildHeight,
    int bufferCount,
  ) {
    final size = (height / minChildHeight) + bufferCount;
    return size.toInt();
  }

  void dispose() => controller.dispose();
}
