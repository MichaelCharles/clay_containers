import 'package:flutter/material.dart';

class ClayText extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? parentColor;
  final Color? textColor;
  final TextStyle? style;
  final double? spread;
  final int? depth;
  final double? size;
  final bool? emboss;

  ClayText(this.text,
      {this.parentColor,
      this.textColor,
      this.color,
      this.spread,
      this.depth,
      this.style,
      this.size,
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

  double? _getSpread(base) {
    double? calculated = (base / 10).floor().toDouble();
    return calculated == 0 ? 1 : calculated;
  }

  @override
  Widget build(BuildContext context) {
    final int? depthValue = depth == null ? 40 : depth;
    Color? colorValue = color == null ? Color(0xFFf0f0f0) : color;
    final Color outerColorValue =
        parentColor == null ? colorValue! : parentColor!;
    double? fontSizeValue = size == null ? 14 : size;
    final TextStyle styleValue = style == null ? TextStyle() : style!;
    fontSizeValue =
        styleValue.fontSize != null ? styleValue.fontSize : fontSizeValue;
    final double spreadValue =
        spread == null ? _getSpread(fontSizeValue)! : spread!;
    final bool embossValue = emboss == null ? false : emboss!;

    List<Shadow> shadowList = [
      Shadow(
          color: _getAdjustColor(
              outerColorValue, embossValue ? 0 - depthValue! : depthValue),
          offset: Offset(0 - spreadValue / 2, 0 - spreadValue / 2),
          blurRadius: spreadValue),
      Shadow(
          color: _getAdjustColor(
              outerColorValue, embossValue ? depthValue : 0 - depthValue!),
          offset: Offset(spreadValue / 2, spreadValue / 2),
          blurRadius: spreadValue)
    ];

    if (embossValue) shadowList = shadowList.reversed.toList();
    if (embossValue) colorValue = _getAdjustColor(colorValue!, 0 - depthValue!);
    if (textColor != null) colorValue = textColor;

    return Text(text,
        style: styleValue.copyWith(
            color: colorValue, shadows: shadowList, fontSize: fontSizeValue));
  }
}
