import 'package:clay_containers/theme/clay_theme_data.dart';
import 'package:flutter/material.dart';

class ClayTheme extends InheritedWidget {
  const ClayTheme({required this.themeData, required super.child, super.key});

  final ClayThemeData themeData;

  ClayThemeData? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<ClayTheme>()?.themeData;
  }

  @override
  bool updateShouldNotify(covariant ClayTheme _) => true;
}
