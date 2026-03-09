import 'package:flutter/material.dart';

Color getColorFromHex(String? hexColor, {Color fallback = Colors.grey}) {
  if (hexColor == null || hexColor.trim().isEmpty) {
    return fallback;
  }

  try {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // أضف شفافية كاملة
    }
    return Color(int.parse(hexColor, radix: 16));
  } catch (e) {
    return fallback;
  }
}
