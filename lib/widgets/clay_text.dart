import 'package:clay_containers/extensions/context_extensions.dart';
import 'package:clay_containers/utils/clay_utils.dart';
import 'package:flutter/material.dart';

class ClayText extends StatefulWidget {
  const ClayText(
    this.text, {
    super.key,
    this.parentColor,
    this.textColor,
    this.color,
    this.spread,
    this.depth,
    this.size,
    this.style,
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

  @override
  State<ClayText> createState() => _ClayTextState();
}

class _ClayTextState extends State<ClayText> {
  late Color color;
  late Color? parentColor;
  late Color? textColor;
  late TextStyle style;
  late double? spread;
  late int depth;
  late double size;
  late bool emboss;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final textTheme = context.clayTheme?.textTheme;
    color = widget.color ?? textTheme?.color ?? const Color(0xFFf0f0f0);
    parentColor = widget.parentColor ?? textTheme?.parentColor;
    textColor = widget.textColor ?? textTheme?.textColor;
    style = widget.style ?? textTheme?.style ?? const TextStyle();
    spread = widget.spread ?? textTheme?.spread;
    depth = widget.depth ?? textTheme?.depth ?? 40;
    size = widget.size ?? textTheme?.size ?? 14;
    emboss = widget.emboss ?? textTheme?.emboss ?? false;
  }

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
      widget.text,
      style: style.copyWith(
        color: colorValue,
        shadows: shadowList,
        fontSize: fontSizeValue,
      ),
    );
  }
}
