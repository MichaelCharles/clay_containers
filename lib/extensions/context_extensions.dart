import 'package:clay_containers/theme/clay_theme.dart';
import 'package:clay_containers/theme/clay_theme_data.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ClayThemeData? get clayTheme => ClayTheme.of(this);
}
