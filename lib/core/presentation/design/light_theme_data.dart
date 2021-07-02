import 'package:shetter_app/core/presentation/presentation.dart';

import 'text_theme.dart';

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
      primaryColor: _primaryColor,
      primaryColorDark: _primaryColorDark,
    );
