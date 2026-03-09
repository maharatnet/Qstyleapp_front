import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    try {
      Notification();
      await CacheHelper.init();
    }catch(e){

    }
    try {
      DioHelper.init();
    }catch(e){

    }
    SharedPreferenceGetValue.token = SharedPreferenceGetValue.getToken();

  }
}


void Notification()async{
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBlCiEfOqRITUJTq2DAJGJEJKjlPz72YqU',
        appId: '1:347105681923:android:2dc3d43a968290dda5a436',
        messagingSenderId: '347105681923',
        projectId: 'maharatecommerce',
        storageBucket: 'maharatecommerce.firebasestorage.app',
      ),
    );
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // AppConstantsVersion.version=await InfoInformation.getVersion() ;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }catch(e){

  }
  // await CacheHelper.init();
  // DioHelper.init();

  try {
    firebaseToken = (await FirebaseMessaging.instance.getToken())!;
    print("firebaseToken -----------");
    print(firebaseToken);
    // print("000000000000000000");
    // print("dGdoblEmTLSM7B8MsqBnUz:APA91bE39DiiEUW_rmJ8boo_Rcc9XLKvmrcPm08XF0khm4gbc8MP9eCPz-V12unf2Dt8YuIOpvz9MXijbUsCDdk80PtbMem0eGUspzkbOzhYZjLcYmiK622bifjC-8p1YeAv7B8aoYLA");
    FirebaseMessaging.onMessage.listen((event) async {
      print('on message');
      print(event.data.toString());
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('on message opened app');
      print(event.data.toString());
    });


    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }catch(e){

  }
}
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print(message.data.toString());

}
String firebaseToken ="";