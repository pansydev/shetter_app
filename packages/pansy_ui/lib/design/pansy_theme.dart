import 'package:pansy_ui/pansy_ui.dart';
import 'package:flutter_color/flutter_color.dart';


class UPansyTheme extends StatelessWidget {
  const UPansyTheme({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _pansyThemeData(),
      child: child,
    );
  }
}

const _backgroundColor = Color(0xFF212121);
const _accentColor = Colors.white;
const _primaryColor = Color(0xFF323232);
const _primaryColorDark = Color(0xFF212121);
const _dividerColor = Colors.white;
const _fontColor = Colors.white;

ThemeData _pansyThemeData() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: _backgroundColor,
    colorScheme: ColorScheme.dark().copyWith(
      primary: _primaryColor,
      secondary: _accentColor,
    ),
    textTheme: textTheme.apply(
      bodyColor: _fontColor,
      displayColor: _fontColor,
    ),
    accentColor: _accentColor,
    primaryColor: _primaryColor,
    primaryColorDark: _primaryColorDark,
    dividerColor: _dividerColor.withOpacity(0.2),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _accentColor,
      selectionColor: _accentColor.withOpacity(0.5),
      selectionHandleColor: _accentColor,
    ),
    iconTheme: IconThemeData(
      color: _fontColor,
      size: 17,
    ),
    buttonColor: _accentColor.darker(70),
  );
}
