import 'package:clay_containers/theme/clay_text_theme.dart';
import 'package:flutter/material.dart';

class ClayThemeData {
  const ClayThemeData({
    this.height,
    this.width,
    this.color = const Color(0xFFf0f0f0),
    this.parentColor,
    this.surfaceColor,
    this.borderRadius,
    this.customBorderRadius,
    this.textTheme,
    this.depth,
    this.emboss = false,
    this.spread,
  });

  final double? height;
  final double? width;
  final Color color;
  final Color? parentColor;
  final Color? surfaceColor;
  final double? borderRadius;
  final BorderRadius? customBorderRadius;
  final int? depth;
  final double? spread;
  final bool emboss;
  final ClayTextTheme? textTheme;

  ClayThemeData copyWith({
    double? height,
    double? width,
    Color? color,
    Color? parentColor,
    Color? surfaceColor,
    double? borderRadius,
    BorderRadius? customBorderRadius,
    int? depth,
    double? spread,
    bool? emboss,
    ClayTextTheme? textTheme,
  }) {
    return ClayThemeData(
      height: height ?? this.height,
      width: width ?? this.width,
      color: color ?? this.color,
      parentColor: parentColor ?? this.parentColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      borderRadius: borderRadius ?? this.borderRadius,
      customBorderRadius: customBorderRadius ?? this.customBorderRadius,
      depth: depth ?? this.depth,
      spread: spread ?? this.spread,
      emboss: emboss ?? this.emboss,
      textTheme: textTheme ?? this.textTheme,
    );
  }
}
