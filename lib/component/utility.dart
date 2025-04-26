import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Utility {
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isWindows => !kIsWeb && Platform.isWindows;
  static bool get isLinux => !kIsWeb && Platform.isLinux;
  static bool get isWeb => kIsWeb;

  static dynamic getValue(String type, dynamic value) {
    if (value == null) {
      if (type == "int") {
        return value = 0;
      } else if (type == "String") {
        return value = "-";
      } else if (type == "double") {
        return value = 0.0;
      }
    } else {
      return value;
    }
  }
  static myPrint(object) async {
    print(object);
  }
  // static TextDirection directory(){
  //   return  SharedPreferenceValue.isEnglish()?TextDirection.rtl: TextDirection.ltr;
  // }


  static String refactorDate(String inputDate) {
    String resultDate, day, month, year;
    if (inputDate.length == 8) {
     day = inputDate.substring(6, 8);
      month = inputDate.substring(4, 6);
      year = inputDate.substring(0, 4);
     resultDate = day + '/' + month + '/' + year;
    } else {
      resultDate = inputDate;
    }

    return resultDate;
  }

  static  PlatformAwareAssetImage(String base){
    return  Utility.isWeb?AssetImage(base.replaceAll("assets/", "")):
    AssetImage(base);
  }
}