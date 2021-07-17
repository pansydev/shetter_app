import 'package:shetter_app/core/presentation/presentation.dart';

extension BuildContextExtensions on BuildContext {
  bool get isDesktop => width < DesignConstants.maxWindowWidth;
}
