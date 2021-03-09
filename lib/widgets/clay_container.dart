import 'package:flutter/material.dart';

import '../constants.dart';

class ClayContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Color? parentColor;
  final Color? surfaceColor;
  final double? spread;
  final Widget? child;
  final double? borderRadius;
  final BorderRadius? customBorderRadius;
  final CurveType? curveType;
  final int? depth;
  final bool? emboss;

  ClayContainer(
      {this.child,
      this.height,
      this.width,
      this.color,
      this.surfaceColor,
      this.parentColor,
      this.spread,
      this.borderRadius,
      this.customBorderRadius,
      this.curveType,
      this.depth,
      this.emboss});

  Color _getAdjustColor(Color baseColor, amount) {
    Map colors = {
      "red": baseColor.red,
      "green": baseColor.green,
      "blue": baseColor.blue
    };
    colors = colors.map((key, value) {
      if (value + amount < 0) return MapEntry(key, 0);
      if (value + amount > 255) return MapEntry(key, 255);
      return MapEntry(key, value + amount);
    });
    return Color.fromRGBO(colors["red"], colors["green"], colors["blue"], 1);
  }

  List<Color?> _getFlatGradients(baseColor, depth) {
    return [
      baseColor,
      baseColor,
    ];
  }

  List<Color> _getConcaveGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, 0 - depth),
      _getAdjustColor(baseColor, depth),
    ];
  }

  List<Color> _getConvexGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, depth),
      _getAdjustColor(baseColor, 0 - depth),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double? heightValue = height == null ? null : height;
    final double? widthValue = width == null ? null : width;
    final int? depthValue = depth == null ? 20 : depth;
    Color? colorValue = color == null ? Color(0xFFf0f0f0) : color;
    final Color parentColorValue =
        parentColor == null ? colorValue! : parentColor!;
    final Color? surfaceColorValue =
        surfaceColor == null ? colorValue : surfaceColor;
    final double spreadValue = spread == null ? 6 : spread!;
    final bool embossValue = emboss == null ? false : emboss!;
    BorderRadius? borderRadiusValue = borderRadius == null
        ? BorderRadius.zero
        : BorderRadius.circular(borderRadius!);

    if (customBorderRadius != null) {
      borderRadiusValue = customBorderRadius;
    }
    final CurveType curveTypeValue =
        curveType == null ? CurveType.none : curveType!;

    List<BoxShadow> shadowList = [
      BoxShadow(
          color: _getAdjustColor(
              parentColorValue, embossValue ? 0 - depthValue! : depthValue),
          offset: Offset(0 - spreadValue, 0 - spreadValue),
          blurRadius: spreadValue),
      BoxShadow(
          color: _getAdjustColor(
              parentColorValue, embossValue ? depthValue : 0 - depthValue!),
          offset: Offset(spreadValue, spreadValue),
          blurRadius: spreadValue)
    ];

    if (embossValue) shadowList = shadowList.reversed.toList();
    if (embossValue)
      colorValue = _getAdjustColor(colorValue!, 0 - depthValue! ~/ 2);
    if (surfaceColor != null) colorValue = surfaceColorValue;

    late List<Color?> gradientColors;
    switch (curveTypeValue) {
      case CurveType.concave:
        gradientColors = _getConcaveGradients(colorValue, depthValue);
        break;
      case CurveType.convex:
        gradientColors = _getConvexGradients(colorValue, depthValue);
        break;
      case CurveType.none:
        gradientColors = _getFlatGradients(colorValue, depthValue);
        break;
    }

    return Container(
      height: heightValue,
      width: widthValue,
      child: child,
      decoration: BoxDecoration(
          borderRadius: borderRadiusValue,
          color: colorValue,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors as List<Color>),
          boxShadow: shadowList),
    );
  }
}
