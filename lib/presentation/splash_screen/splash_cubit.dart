import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/presentation/on_boarding_screen/on_boarding_screen.dart';


class OnSplashCubit extends Cubit<OnSplashState> {
  OnSplashCubit() : super(OnSplashStateInitial());

  static OnSplashCubit get(context) => BlocProvider.of(context);

  late Timer _timer;

  Future<void> initSplash(BuildContext context) async {
    bool is_boarding = true;
    String token = "";
    // try {
    //    is_boarding = await sl<Storage>().getOnBoarding();
    //    token = await sl<Storage>().getToken() ?? "";
    // }catch(e){
    //
    // }
    _timer = Timer(const Duration(seconds: 5), () {
    navigateAndFinish(context, OnBoardingScreen());
    });
  }
}

abstract class OnSplashState {}

class OnSplashStateInitial extends OnSplashState {}

class IntroViewedState extends OnSplashState {}
