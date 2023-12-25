import 'package:flutter/material.dart';

class ClayTextTheme {
  const ClayTextTheme({
    required this.style,
    this.color = const Color(0xFFf0f0f0),
    this.depth = 40,
    this.size = 14,
    this.parentColor,
    this.textColor,
    this.spread,
    this.emboss = false,
  });

  final Color color;
  final Color? parentColor;
  final Color? textColor;
  final TextStyle style;
  final double? spread;
  final int depth;
  final double size;
  final bool emboss;

  ClayTextTheme copyWith({
    Color? color,
    Color? parentColor,
    Color? textColor,
    TextStyle? style,
    double? spread,
    int? depth,
    double? size,
    bool? emboss,
  }) {
    return ClayTextTheme(
      color: color ?? this.color,
      parentColor: parentColor ?? this.parentColor,
      textColor: textColor ?? this.textColor,
      style: style ?? this.style,
      spread: spread ?? this.spread,
      depth: depth ?? this.depth,
      size: size ?? this.size,
      emboss: emboss ?? this.emboss,
    );
  }
}
