import 'package:maharat_ecommerce/component/app_constants.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/network/dio_helper.dart';
import 'package:maharat_ecommerce/network/exception/api_error_handler.dart';

import 'package:dio/dio.dart';


class AttributeRepository {
  static Future<ApiResponse> getFavourite() async {
    try {Response response = await DioHelper.getData(url:AppConstants.favourites);
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }  static Future<ApiResponse> saveFavourite(int productId) async {
    try {Response response = await DioHelper.postData(url:AppConstants.saveFavourite(productId),data: {});
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getNotification() async {
    try {Response response = await DioHelper.getData(url:AppConstants.notifications);
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getBanner() async {
    try {Response response = await DioHelper.getData(url:AppConstants.banners);
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getCategories() async {
    try {Response response = await DioHelper.getData(url:AppConstants.categories);
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getBlogs({bool is_blogs=true}) async {
    try {Response response = await DioHelper.getData(url:AppConstants.blogs,qurey: {
      "type":is_blogs?"blogs":"news",
    });
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getSubCategory(int id) async {
    try {Response response = await DioHelper.getData(url:AppConstants.subcategories(id));
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getProductsDetails(int id) async {
    try {Response response = await DioHelper.getData(url:AppConstants.productsDetails(id));
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> getProducts(Map<String,dynamic> query) async {
    try {Response response = await DioHelper.getData(url:AppConstants.products,qurey: query);
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }  static Future<ApiResponse> getProductAttachments(Map<String,dynamic> query) async {
    try {Response response = await DioHelper.getData(url:AppConstants.product_attachments,qurey: query);
    return ApiResponse.withSuccess(response);
    } catch (e) {
      if(e.toString().contains("SocketException")){
        return ApiResponse.withError("no internet");
      }else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> addStudentAttendance(Map<String,dynamic> data) async {
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
  static Future<ApiResponse> addContactUs(Map<String,dynamic> data) async {
    try {Response response = await DioHelper.postDataFormat(url:AppConstants.contact_us,data:FormData.fromMap(data));
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