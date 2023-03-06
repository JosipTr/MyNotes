import 'package:flutter/material.dart';
import '../colors/generate_material_color.dart';

ThemeData getThemeData() {
  return ThemeData(
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        color: labelColor,
        fontSize: 16,
        fontFamily: 'PlayfairDisplay',
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: labelColor,
        fontFamily: 'PlayfairDisplay',
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        color: labelColor,
        fontFamily: 'PlayfairDisplay',
        fontStyle: FontStyle.italic,
        fontSize: 13,
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
