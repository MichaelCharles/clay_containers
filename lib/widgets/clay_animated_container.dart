import 'package:clay_containers/constants.dart';
import 'package:clay_containers/utils/clay_utils.dart';
import 'package:flutter/material.dart';

class ClayAnimatedContainer extends StatelessWidget {
  const ClayAnimatedContainer({
    super.key,
    this.child,
    this.height,
    this.width,
    this.color = const Color(0xFFf0f0f0),
    this.surfaceColor,
    this.parentColor,
    this.spread = 6,
    this.borderRadius,
    this.customBorderRadius,
    this.curveType,
    this.depth = 20,
    this.emboss = false,
    this.duration,
    this.curve,
  });

  final Duration? duration;
  final Curve? curve;
  final double? height;
  final double? width;
  final Color color;
  final Color? parentColor;
  final Color? surfaceColor;
  final double spread;
  final Widget? child;
  final double? borderRadius;
  final BorderRadius? customBorderRadius;
  final CurveType? curveType;
  final int depth;
  final bool emboss;

  @override
  Widget build(BuildContext context) {
    var colorValue = color;
    final parentColorValue = parentColor ?? colorValue;
    final surfaceColorValue = surfaceColor ?? colorValue;
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
          emboss ? 0 - depth : depth,
        ),
        offset: Offset(0 - spread, 0 - spread),
        blurRadius: spread,
      ),
      BoxShadow(
        color: ClayUtils.getAdjustColor(
          parentColorValue,
          emboss ? depth : 0 - depth,
        ),
        offset: Offset(spread, spread),
        blurRadius: spread,
      ),
    ];

    if (emboss) shadowList = shadowList.reversed.toList();
    if (emboss) {
      colorValue = ClayUtils.getAdjustColor(colorValue, 0 - depth ~/ 2);
    }
    if (surfaceColor != null) colorValue = surfaceColorValue;

    late List<Color?> gradientColors;
    switch (curveTypeValue) {
      case CurveType.concave:
        gradientColors = ClayUtils.getConcaveGradients(colorValue, depth);
      case CurveType.convex:
        gradientColors = ClayUtils.getConvexGradients(colorValue, depth);
      case CurveType.none:
        gradientColors = ClayUtils.getFlatGradients(colorValue, depth);
    }

    return AnimatedContainer(
      duration: duration ?? const Duration(seconds: 1),
      curve: curve ?? Curves.linear,
      height: height,
      width: width,
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
