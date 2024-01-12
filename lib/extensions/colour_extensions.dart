import 'dart:ui';

extension ColorExt on Color {
  Color withIncrement(int amount) => Color.fromRGBO(
        (red + amount).clamp(0, 255),
        (green + amount).clamp(0, 255),
        (blue + amount).clamp(0, 255),
        1,
      );
}
