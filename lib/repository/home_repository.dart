import 'package:maharat_ecommerce/component/app_constants.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/network/dio_helper.dart';
import 'package:maharat_ecommerce/network/exception/api_error_handler.dart';
import 'package:dio/dio.dart';


class HomeRepository {
  static Future<ApiResponse> getDestinations() async {
    try {
      Response response = await DioHelper.getData(
          url: AppConstants.login);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getAllPrograms() async {
    try {
      Response response = await DioHelper.getData(
          url: AppConstants.login);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getBlogs() async {
    try {
      Response response = await DioHelper.getData(
          url: AppConstants.login);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getDestinationPrograms(int id) async {
    try {
      Response response = await DioHelper.getData(
          url: AppConstants.login);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getSingleProgram(int id) async {
    try {
      Response response = await DioHelper.getData(
          url: AppConstants.login);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getSingleBlog(int id) async {
    try {
      Response response = await DioHelper.getData(
          url: AppConstants.login);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }


}