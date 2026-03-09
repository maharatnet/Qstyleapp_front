import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/presentation/auth/forget_password/verify_otp_screen.dart';
import 'package:maharat_ecommerce/presentation/auth/sign_in/sign_in_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'package:maharat_ecommerce/repository/auth_repository.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates>{
  ForgetPasswordCubit():super(AppInitForgetPasswordState());
  static ForgetPasswordCubit get(context)=>BlocProvider.of(context);
  String email = "";
  String? password;
  String? conform_password;
  bool remember = false;
  String? selectedGender ="Male";
  void refreshData(){
    emit(RefreshGeneralInformationState());
  }
  final List<String?> errors = [];
  final formKey = GlobalKey<FormState>();


  void addErrorTWO({String? error}) {
    if (!errors.contains(error)) {
      // setState(() {
      errors.add(error);
      // });
      emit(RefreshRegisterGetStates());
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      // setState(() {
      errors.remove(error);
      // });
      emit(RefreshRegisterGetStates());
    }
  }

  resetPassword(BuildContext context,Map<String,dynamic> data) async {
    print(data);
    try {
      // get_data = true;
      emit(LoadingAccountStates());
      ApiResponse apiResponse = await AuthRepository.resetPassword(
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
          if(SharedPreferenceGetValue.getToken()!=null&&SharedPreferenceGetValue.getToken()!=""){
            navigateAndFinish(context, BottomNavigationScreen());
          }else {
            navigateAndFinish(context, SignInScreen());
          }
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
}
abstract class ForgetPasswordStates  {}
class AppInitForgetPasswordState extends ForgetPasswordStates {}
class LoadingAccountStates extends ForgetPasswordStates {}
class SuccessAccountStates extends ForgetPasswordStates {}
class ErrorAccountStates extends ForgetPasswordStates {}
class RefreshRegisterGetStates extends ForgetPasswordStates {}
class RefreshGeneralInformationState extends ForgetPasswordStates {}