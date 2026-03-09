import 'package:maharat_ecommerce/component/app_constants.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/network/dio_helper.dart';
import 'package:maharat_ecommerce/network/exception/api_error_handler.dart';
import 'package:dio/dio.dart';

class LocationRepository {
  static Future<ApiResponse> getAddress() async {
    try {
      Response response = await DioHelper.getData(url: AppConstants.getAddress);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> addAddress(Map<String, dynamic> data) async {
    try {
      Response response =
      await DioHelper.postData(url: AppConstants.addAddress, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> updateAddress(int addressId, Map<String, dynamic> data) async {
    try {
      Response response = await DioHelper.postData(
          url: AppConstants.updateAddress(addressId), data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> deleteAddress(int cartId) async {
    try {
      Response response = await DioHelper.deleteData(
        url: AppConstants.deleteAddress(cartId),
        data: {},
      );
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
