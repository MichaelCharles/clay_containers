import 'package:clay_containers/constants.dart';
import 'package:clay_containers/extensions/context_extensions.dart';
import 'package:clay_containers/utils/clay_utils.dart';
import 'package:flutter/material.dart';

class ClayAnimatedContainer extends StatefulWidget {
  const ClayAnimatedContainer({
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
    this.duration,
    this.curve,
    this.onEnd,
  });

  final Duration? duration;
  final Curve? curve;
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
  final VoidCallback? onEnd;

  @override
  State<ClayAnimatedContainer> createState() => _ClayAnimatedContainerState();
}

class _ClayAnimatedContainerState extends State<ClayAnimatedContainer> {
  late double? height;
  late double? width;
  late Color color;
  late Color? parentColor;
  late Color? surfaceColor;
  late double? borderRadius;
  late BorderRadius? customBorderRadius;
  late int depth;
  late double spread;
  late bool emboss;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final clayTheme = context.clayTheme;
    height = widget.height ?? clayTheme?.height;
    width = widget.width ?? clayTheme?.width;
    color = widget.color ?? clayTheme?.color ?? const Color(0xFFf0f0f0);
    parentColor = widget.parentColor ?? clayTheme?.parentColor;
    surfaceColor = widget.surfaceColor ?? clayTheme?.surfaceColor;
    borderRadius = widget.borderRadius ?? clayTheme?.borderRadius;
    customBorderRadius =
        widget.customBorderRadius ?? clayTheme?.customBorderRadius;
    depth = widget.depth ?? clayTheme?.depth ?? 20;
    spread = widget.spread ?? clayTheme?.spread ?? 6;
    emboss = widget.emboss ?? clayTheme?.emboss ?? false;
  }

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
    final curveTypeValue = widget.curveType ?? CurveType.none;

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
      duration: widget.duration ?? const Duration(seconds: 1),
      onEnd: widget.onEnd,
      curve: widget.curve ?? Curves.linear,
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
      child: widget.child,
    );
  }
}
