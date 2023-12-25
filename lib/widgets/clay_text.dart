import 'package:clay_containers/utils/clay_utils.dart';
import 'package:flutter/material.dart';

class ClayText extends StatelessWidget {
  const ClayText(
    this.text, {
    super.key,
    this.parentColor,
    this.textColor,
    this.color,
    this.spread,
    this.depth,
    this.style,
    this.size,
    this.emboss,
  });

  final String text;
  final Color? color;
  final Color? parentColor;
  final Color? textColor;
  final TextStyle? style;
  final double? spread;
  final int? depth;
  final double? size;
  final bool? emboss;

  double? _getSpread(double base) {
    final calculated = (base / 10).floor().toDouble();
    return calculated == 0 ? 1 : calculated;
  }

  @override
  Widget build(BuildContext context) {
    final depthValue = depth ?? 40;
    var colorValue = color ?? const Color(0xFFf0f0f0);
    final outerColorValue = parentColor ?? colorValue;
    var fontSizeValue = size ?? 14;
    final styleValue = style ?? const TextStyle();
    fontSizeValue = styleValue.fontSize ?? fontSizeValue;
    final spreadValue = spread ?? _getSpread(fontSizeValue)!;
    final embossValue = emboss ?? false;

    var shadowList = <Shadow>[
      Shadow(
        color: ClayUtils.getAdjustColor(
          outerColorValue,
          embossValue ? 0 - depthValue : depthValue,
        ),
        offset: Offset(0 - spreadValue / 2, 0 - spreadValue / 2),
        blurRadius: spreadValue,
      ),
      Shadow(
        color: ClayUtils.getAdjustColor(
          outerColorValue,
          embossValue ? depthValue : 0 - depthValue,
        ),
        offset: Offset(spreadValue / 2, spreadValue / 2),
        blurRadius: spreadValue,
      ),
    ];

    if (embossValue) shadowList = shadowList.reversed.toList();
    if (embossValue) {
      colorValue = ClayUtils.getAdjustColor(colorValue, 0 - depthValue);
    }
    if (textColor != null) colorValue = textColor!;

    return Text(
      text,
      style: styleValue.copyWith(
        color: colorValue,
        shadows: shadowList,
        fontSize: fontSizeValue,
      ),
    );
  }
}
