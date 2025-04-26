
import 'package:maharat_ecommerce/component/app_constants.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/network/dio_helper.dart';
import 'package:maharat_ecommerce/network/exception/api_error_handler.dart';
import 'package:dio/dio.dart';


class AuthRepository {
  static Future<ApiResponse> login(Map<String,dynamic> data) async {
    try {Response response = await DioHelper.postData(url:AppConstants.login,data:data);
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