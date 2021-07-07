import 'package:shetter_app/core/presentation/presentation.dart';

import 'text_theme.dart';

const _accentColor = Colors.white;
const _backgroundColor = Color(0xFF212121);
const _primaryColor = Color(0xFF323232);
const _primaryColorDark = Color(0xFF1D1D1D);
const _fontColor = Colors.white;

get darkThemeData => ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _backgroundColor,
      colorScheme: ColorScheme.dark().copyWith(
        primary: _primaryColor,
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
