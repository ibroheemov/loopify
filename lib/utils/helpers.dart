import 'dart:ui';

class Helpers {
  static Color parseColor(String colorString) {
    colorString = colorString.replaceAll('#', '');
    int colorValue = int.parse(colorString, radix: 16);
    return Color(colorValue).withOpacity(1);
  }
}
