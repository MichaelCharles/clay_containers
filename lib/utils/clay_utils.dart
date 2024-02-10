import 'dart:ui';

import 'package:clay_containers/extensions/colour_extensions.dart';

abstract class ClayUtils {
  const ClayUtils();

  static List<Color> getFlatGradients(Color baseColor, int depth) {
    return [
      baseColor,
      baseColor,
    ];
  }

  static List<Color> getConcaveGradients(Color baseColor, int depth) {
    return [
      baseColor.withIncrement(0 - depth),
      baseColor.withIncrement(depth),
    ];
  }

  static List<Color> getConvexGradients(Color baseColor, int depth) {
    return [
      baseColor.withIncrement(depth),
      baseColor.withIncrement(0 - depth),
    ];
  }
}
