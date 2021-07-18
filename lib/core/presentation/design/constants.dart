import 'package:shetter_app/core/presentation/presentation.dart';

class DesignConstants {
  // #region sizes
  static const double maxWindowWidth = 600;
  static const double minListTileHeight = 50;
  // #endregion sizes

  // #region borderRadius
  static const Radius borderRadiusValue = Radius.circular(15);
  static const BorderRadius borderRadius = BorderRadius.all(borderRadiusValue);
  static const BorderRadius borderRadiusOnlyTop = BorderRadius.only(
    topLeft: borderRadiusValue,
    topRight: borderRadiusValue,
  );
  static const BorderRadius borderRadiusOnlyBottom = BorderRadius.only(
    bottomLeft: borderRadiusValue,
    bottomRight: borderRadiusValue,
  );

  static Radius borderRadiusCircleValue = Radius.circular(Get.width);
  static BorderRadius borderRadiusCircle = BorderRadius.all(
    borderRadiusCircleValue,
  );
  // #endregion borderRadius

  // #region padding
  static const double paddingValue = 15;
  static const EdgeInsets padding = EdgeInsets.all(paddingValue);

  static const double paddingAltValue = 18;
  static const EdgeInsets paddingAlt = EdgeInsets.symmetric(
    horizontal: paddingValue,
    vertical: paddingAltValue,
  );

  static const double paddingMiniValue = 10;
  static const EdgeInsets paddingMini = EdgeInsets.symmetric(
    horizontal: paddingValue,
    vertical: paddingMiniValue,
  );

  static const EdgeInsets paddingButton = EdgeInsets.symmetric(
    horizontal: paddingAltValue,
    vertical: paddingValue,
  );

  static const EdgeInsets padding7 = EdgeInsets.all(7);
  static const EdgeInsets padding5 = EdgeInsets.all(5);
  // #endregion padding

}
