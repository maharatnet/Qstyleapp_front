import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/model/user_data_model.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/presentation/auth/forget_password/create_new_password_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'package:maharat_ecommerce/repository/auth_repository.dart';

class VerifyAccountCubit extends Cubit<VerifyAccountStates>{
  VerifyAccountCubit():super(AppInitVerifyAccountState());
  static VerifyAccountCubit get(context)=>BlocProvider.of(context);
  TextEditingController textEditingCodeController = TextEditingController();

  UserDataModel ?userDataModel;
  verifyAccountApi(BuildContext context,Map<String,dynamic> data) async {
    print(data);
    try {
      // get_data = true;
      emit(LoadingVerifyAccountStates());
      ApiResponse apiResponse = await AuthRepository.verify_account(
          data);
      print(apiResponse.toString());
      print(apiResponse.response.toString());

      // if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {}else {
      //
      // }
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        try {
          userDataModel = UserDataModel.fromJson(apiResponse!.response!.data);
          SharedPreferenceGetValue.saveToken(
              userDataModel!.data!.access_token ?? "");
          SharedPreferenceGetValue.saveUser(
              json.encode(userDataModel!.toJson()));
          SharedPreferenceGetValue.saveNameProfile(
              userDataModel!.data!.name ?? "");
          appToast(message: userDataModel!.message ?? "",
              type: ToastType.success,
              context: context);
          SharedPreferenceGetValue.token = SharedPreferenceGetValue.getToken();
          navigateAndFinish(context, BottomNavigationScreen());
        }catch(e){
          try {
            // print("adsdasdas");
            // print(apiResponse.response);
            if (apiResponse.response != null &&
                apiResponse.response!.data["code"] != 200)
              appToast(message: apiResponse!.response!.data!["message"],
                  type: ToastType.error,
                  context: context);
          } catch (e) {

          }
        }
        emit(SuccessVerifyAccountStates());
      } else {
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }

        // get_data = false;
        emit(ErrorVerifyAccountStates());
      }
    }catch(e){
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorVerifyAccountStates());
    }
  }
  verifyOtp(BuildContext context,Map<String,dynamic> data) async {
    print(data);
    try {
      // get_data = true;
      emit(LoadingAccountStates());
      ApiResponse apiResponse = await AuthRepository.verifyOtp(
          data);
      print(apiResponse.toString());
      print(apiResponse.response.toString());

      // if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {}else {
      //
      // }
      try {
        // print("adsdasdas");
        // print(apiResponse.response);
        if (apiResponse.response != null &&
            apiResponse.response!.data["code"] != "200") {
          appToast(message: apiResponse!.response!.data!["message"],
              type: ToastType.error,
              context: context);
        }else{
          appToast(message: apiResponse!.response!.data!["message"],
              type: ToastType.success,
              context: context);
          navigateTo(context, CreateNewPasswordScreen(otp:textEditingCodeController.text,email: data["email"],));
        }
      } catch (e) {

      }
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        try {

        }catch(e){
          try {
            // print("adsdasdas");
            // print(apiResponse.response);
            if (apiResponse.response != null &&
                apiResponse.response!.data["code"] != 200)
              appToast(message: apiResponse!.response!.data!["message"],
                  type: ToastType.error,
                  context: context);
          } catch (e) {

          }
        }
        emit(SuccessAccountStates());
      } else {
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }

        // get_data = false;
        emit(ErrorAccountStates());
      }
    }catch(e){
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorAccountStates());
    }
  }

  forgetPassword(BuildContext context,String  email) async {
    // print(data);
    try {
      // get_data = true;
      emit(LoadingVAccountStates());
      ApiResponse apiResponse = await AuthRepository.forgetPassword(
          {
            "email":email
          });
      print(apiResponse.toString());
      print(apiResponse.response.toString());

      // if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {}else {
      //
      // }
      try {
        // print("adsdasdas");
        // print(apiResponse.response);
        if (apiResponse.response != null &&
            apiResponse.response!.data["code"] != "200") {
          appToast(message: apiResponse!.response!.data!["message"],
              type: ToastType.error,
              context: context);
        }else{
          appToast(message: apiResponse!.response!.data!["message"],
              type: ToastType.success,
              context: context);
          // navigateTo(context, VerfiyOtpScreen(email: email,));
        }
      } catch (e) {

      }

      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        try {

        }catch(e) {}
        emit(SuccessVAccountStates());
      } else {
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }

        // get_data = false;
        emit(ErrorVAccountStates());
      }
    }catch(e){
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorVAccountStates());
    }
  }

}
abstract class VerifyAccountStates {}
class AppInitVerifyAccountState extends VerifyAccountStates {}
class RefreshDataVerifyAccountState extends VerifyAccountStates {}
class LoadingVerifyGetStates extends VerifyAccountStates {}
class ErrorVerifyAccountStates extends VerifyAccountStates {}
class SuccessVerifyAccountStates extends VerifyAccountStates {}
class LoadingVerifyAccountStates extends VerifyAccountStates {}
class ErrorAccountStates extends VerifyAccountStates {}
class SuccessAccountStates extends VerifyAccountStates {}
class LoadingAccountStates extends VerifyAccountStates {}
class LoadingVAccountStates extends VerifyAccountStates {}
class SuccessVAccountStates extends VerifyAccountStates {}
class ErrorVAccountStates extends VerifyAccountStates {}