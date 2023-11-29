import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color colorPrimary = HexColor("#1D828E");
Color colorPrimaryVariant = HexColor("#1D828E");
Color colorPrimaryDark = HexColor("#eea24a");
Color colorOnPrimary = HexColor("#DAFFFB");
Color colorText = HexColor("#140f1f");
Color colorRed100 = HexColor("#FFCDD2");
Color colorGreen100 = HexColor("#C8E6C9");
Color colorBlue100 = HexColor("#BBDEFB");