import 'package:shetter_app/core/presentation/presentation.dart';

import 'text_theme.dart';

const _accentColor = Colors.black;
const _backgroundColor = Color(0xFFFAFAFA);
const _primaryColor = Color(0xFFFFFFFF);
const _primaryColorDark = Color(0xFFFFFFFF);
const _fontColor = Colors.black;

get lightThemeData => ThemeData.light().copyWith(
      scaffoldBackgroundColor: _backgroundColor,
      colorScheme: ColorScheme.light().copyWith(
        secondary: Colors.grey,
      ),
      textTheme: textTheme.apply(
        bodyColor: _fontColor,
        displayColor: _fontColor,
      ),
      accentColor: _accentColor,
      primaryColor: _primaryColor,
      primaryColorDark: _primaryColorDark,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: _accentColor,
        selectionColor: _accentColor.withOpacity(0.5),
        selectionHandleColor: _accentColor,
      ),
    );
