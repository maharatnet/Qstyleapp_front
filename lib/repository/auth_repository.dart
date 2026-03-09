
import 'package:maharat_ecommerce/component/app_constants.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/network/dio_helper.dart';
import 'package:maharat_ecommerce/network/exception/api_error_handler.dart';
import 'package:dio/dio.dart';


class AuthRepository {
  static Future<ApiResponse> login(Map<String,dynamic> data) async {
    try {Response response = await DioHelper.postDataFormat(url:AppConstants.login,data:FormData.fromMap(data));
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> register(Map<String,dynamic> data) async {
    try {Response response = await DioHelper.postData(url:AppConstants.register,data:data);
    print(AppConstants.base_url+AppConstants.register);
    // print();
    // try {Response response = await DioHelper.postDataFormat(url:AppConstants.register,data:FormData.fromMap(data));
   print("response.data");
   print(response.data.toString());
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e is DioException) {
        print('Status Code: ${e.response?.statusCode}');
        print('Response Data: ${e.response?.data}');
        print('Headers: ${e.response?.headers}');
        print('Request Data: ${e.requestOptions.data}');
        print('Request Headers: ${e.requestOptions.headers}');
        print('Error Message: ${e.message}');
      }
      print("e.toString()1");
      print(e.toString());
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        print("e.toString()");
        print(e.toString());
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  static Future<ApiResponse> verify_account(Map<String,dynamic> data) async {
    try {Response response = await DioHelper.postDataFormat(url:AppConstants.verify_account,data:FormData.fromMap(data));
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> forgetPassword(Map<String,dynamic> data) async {
    try {Response response = await DioHelper.postData(url:AppConstants.forgetPassword,data:data);
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }  static Future<ApiResponse> verifyOtp(Map<String,dynamic> data) async {
    try {Response response = await DioHelper.postData(url:AppConstants.verifyOtp,data:data);
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  } static Future<ApiResponse> resetPassword(Map<String,dynamic> data) async {
    try {Response response = await DioHelper.postData(url:AppConstants.resetPassword,data:data);
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  static Future<ApiResponse> updateProfile(Map<String,dynamic> data) async {
    try {Response response = await DioHelper.postDataFormat(url:AppConstants.updateProfile,data:FormData.fromMap(data));
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

}