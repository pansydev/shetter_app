import 'package:pansy_ui/pansy_ui.dart';

extension UBuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  double get textScaleFactor => mediaQuery.textScaleFactor;

  UDesign get design => UDesign.of(this);
  UDesignConstraints get designConstraints => design.constraints;

  bool get isDesktop =>
      MediaQuery.of(this).size.width > designConstraints.maxPhoneWidth;
}
