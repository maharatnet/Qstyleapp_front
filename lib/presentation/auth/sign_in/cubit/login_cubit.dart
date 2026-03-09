import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/model/user_data_model.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/presentation/auth/verfiy_account/verfiy_account_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'package:maharat_ecommerce/repository/auth_repository.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(AppInitLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;

  bool obscureText =true;

  void changeObscureText(){
    obscureText =!obscureText;
    emit(RefreshLoginStates());
  }
  final List<String?> errors = [];

  void addTwoError({String? error}) {
    if (!errors.contains(error)) {
      // setState(() {
        errors.add(error);
      // });
      emit(RefreshLoginStates());
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      // setState(() {
        errors.remove(error);
      // });
        emit(RefreshLoginStates());
    }
  }


  UserDataModel ?userDataModel;
  loginApi(BuildContext context,Map<String,dynamic> data) async {
    print(data);
    try {
      // get_data = true;
      emit(LoadingLoginGetStates());
      ApiResponse apiResponse = await AuthRepository.login(
          data);
      print(apiResponse.toString());
      print(apiResponse.response.toString());
      print(apiResponse.response!.data["message"].toString());

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        try{
          print("adsdasdas");
          print(apiResponse.response);
          if(apiResponse.response!=null&&apiResponse.response!.data["code"] != 200||apiResponse.response!.data["code"] != "200")
            if(apiResponse.response!.data["code"] != 200&&apiResponse.response!.data["code"] != "200")
            appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);

        }catch(e){

        }
      }else{



      }
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        userDataModel = UserDataModel.fromJson(apiResponse!.response!.data);
        SharedPreferenceGetValue.saveToken(userDataModel!.data!.access_token??"");
        SharedPreferenceGetValue.saveUser(json.encode(userDataModel!.toJson()));


      SharedPreferenceGetValue.saveNameProfile(userDataModel!.data!.name??"");
      SharedPreferenceGetValue.saveImageProfile(userDataModel!.data!.photoProfile??"");
        SharedPreferenceGetValue.token = SharedPreferenceGetValue.getToken();
        appToast(message: userDataModel!.message??"success", type: ToastType.success, context: context);

        navigateTo(context, BottomNavigationScreen());
        emit(SuccessLoginGetStates());
      } else if(apiResponse.response!.statusCode==422){
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }
      } else if(apiResponse.response!.statusCode==433){
        navigateTo(context, VerifyAccountScreen(email: email??"", password: password??"",));
      }else{

        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }

        // get_data = false;
        emit(ErrorLoginStates());
      }
    }catch(e){

      // appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorLoginStates());
    }
  }


  void refreshData(){
    emit(RefreshLoginStates());
  }

}

abstract class LoginStates {}

class AppInitLoginState extends LoginStates {}

class AppRefreshDataState extends LoginStates {}
class LoadingLoginGetStates extends LoginStates {}
class SuccessLoginGetStates extends LoginStates {}
class ErrorLoginStates extends LoginStates {}
class RefreshLoginStates extends LoginStates {}
