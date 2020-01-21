library clay_containers;

import 'package:flutter/material.dart';

class ClayContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final double spread;
  final Widget child;
  final double borderRadius;
  final BorderRadius customBorderRadius;
  final CurveType curveType;
  final int depth;

  ClayContainer(
      {this.child,
      this.height,
      this.width,
      @required this.color,
      this.spread,
      this.borderRadius,
      this.customBorderRadius,
      this.curveType,
      this.depth});

  Color _getAdjustColor(Color baseColor, amount) {
    Map colors = {
      "red": baseColor.red,
      "green": baseColor.green,
      "blue": baseColor.blue
    };
    colors = colors.map((key, value) {
      int result = 0;
      if (value + amount < 0) return MapEntry(key, 0);
      if (value + amount > 255) return MapEntry(key, 255);
      return MapEntry(key, value + amount);
    });
    return Color.fromRGBO(colors["red"], colors["green"], colors["blue"], 1);
  }

  List<Color> _getFlatGradients(baseColor, depth) {
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
    final double heightValue = height == null ? null : height;
    final double widthValue = width == null ? null : width;
    final int depthValue = depth == null ? 20 : depth;
    final Color colorValue = color;
    final double spreadValue = spread == null ? 6 : spread;
    BorderRadius borderRadiusValue = borderRadius == null
        ? BorderRadius.zero
        : BorderRadius.circular(borderRadius);

    if (customBorderRadius != null) {
      borderRadiusValue = customBorderRadius;
    }
    final CurveType curveTypeValue =
        curveType == null ? CurveType.none : curveType;

    List<Color> gradientColors;
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
              colors: gradientColors),
          boxShadow: [
            BoxShadow(
                color: _getAdjustColor(colorValue, depthValue),
                offset: Offset(0 - spreadValue, 0 - spreadValue),
                blurRadius: spreadValue),
            BoxShadow(
                color: _getAdjustColor(colorValue, 0 - depthValue),
                offset: Offset(spreadValue, spreadValue),
                blurRadius: spreadValue)
          ]),
    );
  }
}

enum CurveType { concave, convex, none }
