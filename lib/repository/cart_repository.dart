import 'package:maharat_ecommerce/component/app_constants.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/network/dio_helper.dart';
import 'package:maharat_ecommerce/network/exception/api_error_handler.dart';
import 'package:dio/dio.dart';

class CartRepository {
  static Future<ApiResponse> getCart({int address_id =0}) async {
    try {
      print( address_id==0?AppConstants.cart:AppConstants.cart+"?address_id=${address_id}");
      Response response = await DioHelper.getData(url: AppConstants.cart,qurey:address_id==0?{}:{
        "address_id":address_id
      } );
     print(response.data.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> addCart(Map<String, dynamic> data) async {
    try {
      Response response =
          await DioHelper.postData(url: AppConstants.cart, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> addOrders(Map<String, dynamic> data) async {
    try {
      Response response =
          await DioHelper.postData(url: AppConstants.orders, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> updateCart(
      int cartId, Map<String, dynamic> data) async {
    try {
      Response response = await DioHelper.postData(
          url: AppConstants.updateCart(cartId), data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  static Future<ApiResponse> deleteCart(int cartId) async {
    try {
      Response response = await DioHelper.deleteData(
        url: AppConstants.deleteCart(cartId),
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

  static Future<ApiResponse> checkProduct(Map<String, dynamic> data) async {
    try {
      Response response =
          await DioHelper.postData(url: AppConstants.check_product, data: data);
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
