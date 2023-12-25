import 'package:clay_containers/constants.dart';
import 'package:flutter/material.dart';

class ClayThemeData {
  const ClayThemeData({
    this.height,
    this.width,
    this.color,
    this.parentColor,
    this.surfaceColor,
    this.spread,
    this.borderRadius,
    this.customBorderRadius,
    this.curveType,
    this.depth,
    this.emboss = false,
  });

  final double? height;
  final double? width;
  final Color? color;
  final Color? parentColor;
  final Color? surfaceColor;
  final double? spread;
  final double? borderRadius;
  final BorderRadius? customBorderRadius;
  final CurveType? curveType;
  final int? depth;
  final bool emboss;

  ClayThemeData copyWith({
    double? height,
    double? width,
    Color? color,
    Color? parentColor,
    Color? surfaceColor,
    double? spread,
    double? borderRadius,
    BorderRadius? customBorderRadius,
    CurveType? curveType,
    int? depth,
    bool? emboss,
  }) {
    return ClayThemeData(
      height: height ?? this.height,
      width: width ?? this.width,
      color: color ?? this.color,
      parentColor: parentColor ?? this.parentColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      spread: spread ?? this.spread,
      borderRadius: borderRadius ?? this.borderRadius,
      customBorderRadius: customBorderRadius ?? this.customBorderRadius,
      curveType: curveType ?? this.curveType,
      depth: depth ?? this.depth,
      emboss: emboss ?? this.emboss,
    );
  }
}
