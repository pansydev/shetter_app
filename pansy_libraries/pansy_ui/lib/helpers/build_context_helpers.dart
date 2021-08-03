import 'package:pansy_ui/pansy_ui.dart';

extension UBuildContextThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
}

extension UBuildContextMediaQueryExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  double get textScaleFactor => mediaQuery.textScaleFactor;
}

extension UBuildContextDesignExtensions on BuildContext {
  UDesign get design => UDesign.of(this);
  UDesignConstraints get designConstraints => design.constraints;
}

extension UBuildContextPlatformExtensions on BuildContext {
  bool get isDesktop => this.width > this.designConstraints.maxPhoneWidth;
}
