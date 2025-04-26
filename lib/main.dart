import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/core/connective_tracker.dart';
import 'package:maharat_ecommerce/core/default_offline_widget.dart';
import 'package:maharat_ecommerce/presentation/splash_screen/splash_screen.dart';
import 'package:maharat_ecommerce/start_up.dart';

void main() async {
  await StartUp.instance!.init();
  runApp(    EasyLocalization(
      supportedLocales: [ Locale('ar'),Locale('en'),],
      path: 'assets/language', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      startLocale: Locale('en'),
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConnectivityTracker(
      offlineWidget: const DefaultOfflineWidget(),
      child: MaterialApp(
        title: 'QStyle',
        debugShowCheckedModeBanner:false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:SplashScreen(), //const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
