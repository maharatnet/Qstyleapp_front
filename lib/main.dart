import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:maharat_ecommerce/core/connective_tracker.dart';
import 'package:maharat_ecommerce/core/default_offline_widget.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navigation_cubit.dart';
import 'package:maharat_ecommerce/presentation/splash_screen/splash_screen.dart';
import 'package:maharat_ecommerce/start_up.dart';

void main() async {

  try {
    await StartUp.instance!.init();
    Stripe.publishableKey = "";
    Stripe.merchantIdentifier = 'any string works';
    await Stripe.instance.applySettings();
  }catch(e){

  }



  runApp(    EasyLocalization(
      supportedLocales: [ Locale('ar'),Locale('en'),],
      path: 'assets/language', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      // startLocale: Locale('en'),
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>BottomNavigationCubit()
      ..getNotificationApi(context),
  child: BlocConsumer<BottomNavigationCubit,BottomNavigationStates>(
      listener: (context,state){},
      builder: (context,state){
        // final cubit =  BottomNavigationCubit.get(context);
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

      },
   ),
  );
  }
}

