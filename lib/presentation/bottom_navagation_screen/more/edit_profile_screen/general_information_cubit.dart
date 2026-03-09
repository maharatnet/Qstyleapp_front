import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/model/user_data_model.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'package:maharat_ecommerce/repository/auth_repository.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class GeneralInformationCubit extends Cubit<GeneralInformationStates>{
  GeneralInformationCubit():super(AppInitGeneralInformationState());
  static GeneralInformationCubit get(context)=>BlocProvider.of(context);
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
 String imageUrl = "";
  String selectedGender ="Male";
  UserDataModel? userDataModel;
  String isoCode ="EG";
bool is_get_data = false;
  void initData()async {
    try {
      is_get_data = true;
      refreshData();
      String data = await SharedPreferenceGetValue.getUser();
      userDataModel = UserDataModel.fromJson(json.decode(data));
      print("ussewwwr");
      print("${userDataModel!.toJson()}");
      userNameController.text = userDataModel!.data!.name ?? "";
      emailController.text = userDataModel!.data!.email ?? "";
      phoneController.text = userDataModel!.data!.mobile ?? "";
      imageUrl = userDataModel!.data!.photoProfile ?? "";
      selectedGender = userDataModel!.data!.gender==null||userDataModel!.data!.gender==""? "Male":userDataModel!.data!.gender??"Male";
      try {
        // تحليل الرقم من النص الكامل
        final phoneNumber = PhoneNumber.parse(phoneController.text);

        print('Country Code: +${phoneNumber.countryCode}'); // +20
        print('ISO Code: ${phoneNumber.isoCode}'); // EG
        print('National Number: ${phoneNumber.nsn}'); // 1010313836
        isoCode = phoneNumber.isoCode.name;
        print("isoCodeisoCode");
        print(isoCode);
        phoneController.text = phoneNumber.nsn;
        refreshData();
      } catch (e) {
        is_get_data = false;
        print('Error parsing phone number: $e');
      }

      // print("object");
      // print(data.toString());
    } catch (e) {
is_get_data = false;
    }

is_get_data = false;
    refreshData();
  }


  void refreshData(){
    emit(RefreshGeneralInformationState());
  }
  updateProfileApi(BuildContext context,Map<String,dynamic> data) async {
    print(data);
    try {
      // get_data = true;
      emit(LoadingUpdateGetStates());
      ApiResponse apiResponse = await AuthRepository.updateProfile(
          data);
      // print(apiResponse.toString());
      // print(apiResponse.response.toString());
      // print(apiResponse.response!.data["message"].toString());

      // if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {}else {
        try {
          print("adsdasdas");
          print(apiResponse.response);
          if (apiResponse.response != null &&
              apiResponse.response!.data["code"] != 200&&apiResponse.response!.data["status"]==false)
            appToast(message: apiResponse!.response!.data!["message"],
                type: ToastType.error,
                context: context);
        } catch (e) {

        // }
      }
      // try{
      //   // print("adsdasdas");
      //   // print(apiResponse.response);
      //   if(apiResponse.response!=null&&apiResponse.response!.data["code"] != 200)
      //     appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
      //
      // }catch(e){
      //
      // }
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        userDataModel = UserDataModel.fromJson(apiResponse!.response!.data);
        SharedPreferenceGetValue.saveUser(json.encode(userDataModel!.toJson()));

        SharedPreferenceGetValue.saveNameProfile(userDataModel!.data!.name??"");
        SharedPreferenceGetValue.saveImageProfile(userDataModel!.data!.photoProfile??"");

        appToast(message: userDataModel!.message??"", type: ToastType.success, context: context);
       navigateAndFinish(context, BottomNavigationScreen(startIndex: 3,));
        emit(SuccessUpdateGetStates());
      } else if(apiResponse.response!.statusCode==422){
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }
      } else if(apiResponse.response!.statusCode==433){
      }else{

        try {
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
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }

        // get_data = false;
        emit(ErrorUpdateStates());
      }
    }catch(e){

      // appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorUpdateStates());
    }
  }

  File ?selectedImage;
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      emit(SomeStateThatRefreshesUI()); // مثلا state جديد لتحديث الواجهة
    }
  }
}

abstract class GeneralInformationStates {}
class AppInitGeneralInformationState extends GeneralInformationStates {}
class RefreshGeneralInformationState extends GeneralInformationStates {}
class LoadingUpdateGetStates extends GeneralInformationStates {}
class SuccessUpdateGetStates extends GeneralInformationStates {}
class ErrorUpdateStates extends GeneralInformationStates {}
class SomeStateThatRefreshesUI extends GeneralInformationStates {}