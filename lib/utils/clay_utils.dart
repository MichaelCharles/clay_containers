
import 'dart:ui';

abstract class ClayUtils {
  const ClayUtils();

  static Color getAdjustColor(Color baseColor, int amount) {
    var colors = <String, int>{
      'red': baseColor.red,
      'green': baseColor.green,
      'blue': baseColor.blue,
    };
    colors = colors.map((key, value) {
      if (value + amount < 0) return MapEntry(key, 0);
      if (value + amount > 255) return MapEntry(key, 255);
      return MapEntry(key, value + amount);
    });
    return Color.fromRGBO(colors['red']!, colors['green']!, colors['blue']!, 1);
  }

  static List<Color> getFlatGradients(Color baseColor, int depth) {
    return [
      baseColor,
      baseColor,
    ];
  }

  static List<Color> getConcaveGradients(Color baseColor, int depth) {
    return [
      getAdjustColor(baseColor, 0 - depth),
      getAdjustColor(baseColor, depth),
    ];
  }

  static List<Color> getConvexGradients(Color baseColor, int depth) {
    return [
      getAdjustColor(baseColor, depth),
      getAdjustColor(baseColor, 0 - depth),
    ];
  }
}
