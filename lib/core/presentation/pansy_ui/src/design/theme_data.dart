import 'package:flutter_color/flutter_color.dart';
import '../../pansy_ui.dart';

import 'text_theme.dart';

const _backgroundColor = Color(0xFF212121);
const _primaryColor = Color(0xFF323232);
const _primaryColorDark = Color(0xFF1D1D1D);
const _dividerColor = Colors.white;
const _fontColor = Colors.white;

ThemeData themeData({
  Color accentColor = Colors.deepPurpleAccent,
  double accentRatio = 0.5,
}) {
  final _accentColor = _backgroundColor
      .mix(accentColor, accentRatio)!
      .lighter((25 - (accentRatio * 10)).toInt());
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: _backgroundColor.mix(_accentColor, 0.1),
    colorScheme: ColorScheme.dark().copyWith(
      primary: _primaryColor.mix(_accentColor, 0.1),
      secondary: _accentColor,
    ),
    textTheme: textTheme.apply(
      bodyColor: _fontColor,
      displayColor: _fontColor,
    ),
    accentColor: _accentColor,
    primaryColor: _primaryColor.mix(_accentColor, 0.2),
    primaryColorDark: _primaryColorDark.mix(_accentColor, 0.1),
    dividerColor: _dividerColor.mix(_accentColor, 0.2)?.withOpacity(0.2),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _accentColor,
      selectionColor: _accentColor.withOpacity(0.5),
      selectionHandleColor: _accentColor,
    ),
    iconTheme: IconThemeData(
      color: _fontColor.mix(_accentColor, 0.1),
      size: 17,
    ),
  );
}
