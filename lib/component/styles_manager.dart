import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(  fontSize: fontSize,
      color: color,
     fontFamily: "NunitoSans",
     // fontFamily: "Rasa",
      fontWeight: fontWeight );

}
TextStyle _getTextStyleTwo(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontFamily: "NunitoSans",
      // fontFamily: "Rasa",
      decoration: TextDecoration.underline,
      fontWeight: fontWeight);
}

TextStyle getTextStyle({double fontSize = FontSize.s18, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

// regular style
TextStyle getAppBarStyle(
    {  double? fontSize , required Color color}) {
  return _getTextStyle(fontSize??FontSize.s18, FontWeightManager.bold, color);
}

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}
TextStyle getRegularLineStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyleTwo(fontSize, FontWeightManager.regular, color);
}

// medium style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// medium style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

// bold style

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color,);
}

// semibold style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
