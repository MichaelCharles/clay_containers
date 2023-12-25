import 'package:clay_containers/utils/clay_utils.dart';
import 'package:flutter/material.dart';

class ClayText extends StatelessWidget {
  const ClayText(
    this.text, {
    super.key,
    this.parentColor,
    this.textColor,
    this.color = const Color(0xFFf0f0f0),
    this.spread,
    this.depth = 40,
    this.style = const TextStyle(),
    this.size = 14,
    this.emboss = false,
  });

  final String text;
  final Color color;
  final Color? parentColor;
  final Color? textColor;
  final TextStyle style;
  final double? spread;
  final int depth;
  final double size;
  final bool emboss;

  double? _getSpread(double base) {
    final calculated = (base / 10).floor().toDouble();
    return calculated == 0 ? 1 : calculated;
  }

  @override
  Widget build(BuildContext context) {
    var colorValue = color;
    final outerColorValue = parentColor ?? colorValue;
    var fontSizeValue = size;
    fontSizeValue = style.fontSize ?? fontSizeValue;
    final spreadValue = spread ?? _getSpread(fontSizeValue)!;

    var shadowList = <Shadow>[
      Shadow(
        color: ClayUtils.getAdjustColor(
          outerColorValue,
          emboss ? 0 - depth : depth,
        ),
        offset: Offset(0 - spreadValue / 2, 0 - spreadValue / 2),
        blurRadius: spreadValue,
      ),
      Shadow(
        color: ClayUtils.getAdjustColor(
          outerColorValue,
          emboss ? depth : 0 - depth,
        ),
        offset: Offset(spreadValue / 2, spreadValue / 2),
        blurRadius: spreadValue,
      ),
    ];

    if (emboss) shadowList = shadowList.reversed.toList();
    if (emboss) {
      colorValue = ClayUtils.getAdjustColor(colorValue, 0 - depth);
    }
    if (textColor != null) colorValue = textColor!;

    return Text(
      text,
      style: style.copyWith(
        color: colorValue,
        shadows: shadowList,
        fontSize: fontSizeValue,
      ),
    );
  }
}
