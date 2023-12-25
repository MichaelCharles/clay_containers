import 'package:clay_containers/constants.dart';
import 'package:clay_containers/utils/clay_utils.dart';
import 'package:flutter/material.dart';

class ClayContainer extends StatelessWidget {
  const ClayContainer({
    super.key,
    this.child,
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
    this.emboss,
  });
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

  @override
  Widget build(BuildContext context) {
    final heightValue = height;
    final widthValue = width;
    final depthValue = depth ?? 20;
    var colorValue = color ?? const Color(0xFFf0f0f0);
    final parentColorValue = parentColor ?? colorValue;
    final surfaceColorValue = surfaceColor ?? colorValue;
    final spreadValue = spread ?? 6;
    final embossValue = emboss ?? false;
    BorderRadius? borderRadiusValue = borderRadius == null
        ? BorderRadius.zero
        : BorderRadius.circular(borderRadius!);

    if (customBorderRadius != null) {
      borderRadiusValue = customBorderRadius;
    }
    final curveTypeValue = curveType == null ? CurveType.none : curveType!;

    var shadowList = <BoxShadow>[
      BoxShadow(
        color: ClayUtils.getAdjustColor(
          parentColorValue,
          embossValue ? 0 - depthValue : depthValue,
        ),
        offset: Offset(0 - spreadValue, 0 - spreadValue),
        blurRadius: spreadValue,
      ),
      BoxShadow(
        color: ClayUtils.getAdjustColor(
          parentColorValue,
          embossValue ? depthValue : 0 - depthValue,
        ),
        offset: Offset(spreadValue, spreadValue),
        blurRadius: spreadValue,
      ),
    ];

    if (embossValue) shadowList = shadowList.reversed.toList();
    if (embossValue) {
      colorValue = ClayUtils.getAdjustColor(colorValue, 0 - depthValue ~/ 2);
    }
    if (surfaceColor != null) colorValue = surfaceColorValue;

    late List<Color?> gradientColors;
    switch (curveTypeValue) {
      case CurveType.concave:
        gradientColors = ClayUtils.getConcaveGradients(colorValue, depthValue);
      case CurveType.convex:
        gradientColors = ClayUtils.getConvexGradients(colorValue, depthValue);
      case CurveType.none:
        gradientColors = ClayUtils.getFlatGradients(colorValue, depthValue);
    }

    return Container(
      height: heightValue,
      width: widthValue,
      decoration: BoxDecoration(
        borderRadius: borderRadiusValue,
        color: colorValue,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors as List<Color>,
        ),
        boxShadow: shadowList,
      ),
      child: child,
    );
  }
}
