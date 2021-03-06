import 'package:pansy_ui/pansy_ui.dart';

const _fontName = 'Ubuntu';

const _defaultTextStyle = TextStyle(fontFamily: _fontName);

final textTheme = TextTheme(
  headline1: _defaultTextStyle,
  headline2: _defaultTextStyle,
  headline3: _defaultTextStyle,
  headline4: _defaultTextStyle,
  headline5: _defaultTextStyle,
  headline6: _defaultTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 15,
  ),
  bodyText1: _defaultTextStyle,
  bodyText2: _defaultTextStyle,
  overline: _defaultTextStyle,
  subtitle1: _defaultTextStyle,
  subtitle2: _defaultTextStyle,
  caption: _defaultTextStyle,
  button: _defaultTextStyle,
);
