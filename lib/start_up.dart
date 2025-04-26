import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/network/cache_helper.dart';
import 'package:maharat_ecommerce/network/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartUp {
  static StartUp? _instance;
  StartUp._() {}
  static StartUp? get instance {
    if (_instance != null) return _instance;
    return _instance = StartUp._();
  }

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableBuildModes = [];
    // await EasyLocalization.ensureInitialized();
    // EasyLocalization.logger.enableBuildModes = [];
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor:
      ColorManager.backgroundColor
      ),
    );


    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    //     statusBarColor: Colors.transparent, // Color for Android
    //     statusBarBrightness:
    //         Brightness.light // Dark == white status bar -- for IOS.
    //     ));
    // await Future.wait([,]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    await CacheHelper.init();
    DioHelper.init();
    SharedPreferenceGetValue.token = SharedPreferenceGetValue.getToken();

  }
}
