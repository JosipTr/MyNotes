import 'package:flutter/material.dart';
import '../colors/generate_material_color.dart';

ThemeData getThemeData() {
  return ThemeData(
    fontFamily: 'PlayfairDisplay',
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        color: labelColor,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: labelColor,
        fontSize: 17,
      ),
      labelSmall: TextStyle(
        color: labelColor,
        fontStyle: FontStyle.italic,
        fontSize: 15,
      ),
    ),
    cardColor: const Color.fromRGBO(252, 255, 231, 1),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: generateMaterialColor(
        const Color.fromRGBO(43, 52, 103, 1),
      ),
    ).copyWith(
      background: scaffoldBackgroundColor,
    ),
    scaffoldBackgroundColor: scaffoldBackgroundColor,
  );
}
