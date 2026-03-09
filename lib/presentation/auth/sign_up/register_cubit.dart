import 'package:easy_localization/easy_localization.dart';
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

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(AppInitRegisterStates());
 static RegisterCubit get(context)=>BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  String? email;
  String? name;
  String? phone;
  String? password;
  String? conform_password;
  bool remember = false;
  String? selectedGender ="Male";
  void refreshData(){
    emit(RefreshGeneralInformationState());
  }
  final List<String?> errors = [];

  void addErrorTwo({String? error}) {
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
  UserDataModel ?userDataModel;
  registerApi(BuildContext context,Map<String,dynamic> data) async {
    print(data);
    try {
      // get_data = true;
      emit(LoadingRegisterGetStates());
      ApiResponse apiResponse = await AuthRepository.register(data);
      // print(apiResponse.error.toString());
      // print(apiResponse.error.toString());
      // print(apiResponse.response.toString());
      // print(apiResponse.response!.statusCode.toString());
      // print(apiResponse.response!.data.toString());
      // print(apiResponse.response!.data.toString());
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        appToast(message: "theAccountHasBeenCreated".tr(), type: ToastType.success, context: context);

        navigateTo(context, VerifyAccountScreen(email: email??"", password: password??"",));
        emit(SuccessRegisterGetStates());
      } else {
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }

        // get_data = false;
        emit(ErrorRegisterStates());
      }
    }catch(e){
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorRegisterStates());
    }
  }

}
abstract class RegisterStates {}
class AppInitRegisterStates extends RegisterStates {}
class RefreshRegisterStates extends RegisterStates {}
class LoadingRegisterGetStates extends RegisterStates {}
class ErrorRegisterStates extends RegisterStates {}
class SuccessRegisterGetStates extends RegisterStates {}
class RefreshGeneralInformationState extends RegisterStates {}
class RefreshRegisterGetStates extends RegisterStates {}