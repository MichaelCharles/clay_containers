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
  });

  final double? height;
  final double? width;
  final Color color;
  final Color? parentColor;
  final Color? surfaceColor;
  final double? borderRadius;
  final BorderRadius? customBorderRadius;
  ClayThemeData copyWith({
    double? height,
    double? width,
    Color? color,
    Color? parentColor,
    Color? surfaceColor,
    double? spread,
    double? borderRadius,
    BorderRadius? customBorderRadius,
    int? depth,
  }) {
    return ClayThemeData(
      height: height ?? this.height,
      width: width ?? this.width,
      color: color ?? this.color,
      parentColor: parentColor ?? this.parentColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      borderRadius: borderRadius ?? this.borderRadius,
      customBorderRadius: customBorderRadius ?? this.customBorderRadius,
    );
  }
}
