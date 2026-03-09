import 'package:maharat_ecommerce/component/app_constants.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/network/dio_helper.dart';
import 'package:maharat_ecommerce/network/exception/api_error_handler.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  static Future<ApiResponse> getBanners() async {
    try {
      Response response = await DioHelper.getData(url: AppConstants.banners);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  static Future<ApiResponse> getCategory() async {
    try {
      Response response = await DioHelper.getData(url: AppConstants.categories);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  static Future<ApiResponse> getCategoryProduct(int categoryId,int is_international) async {
    try {
      print(AppConstants.categoriesProduct(categoryId)+"?is_international=$is_international");
      Response response = await DioHelper.getData(
          url: AppConstants.categoriesProduct(categoryId)+"?is_international=$is_international",
          // qurey: {
          //   "is_international":is_international,
      // }
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

  static Future<ApiResponse> getProductDetails(int categoryId) async {
    try {
      Response response = await DioHelper.getData(
          url: AppConstants.productsDetails(categoryId));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  static Future<ApiResponse> addOrRemoveFavourite(int categoryId) async {
    try {
      Response response = await DioHelper.postData(
          url: AppConstants.saveFavourite(categoryId), data: {});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
  static Future<ApiResponse> checkProduct(Map<String,dynamic> data) async {
    try {
      //product_id
      //quantity
      //size_id
      //color_id
      Response response = await DioHelper.postData(
          url: AppConstants.checkProduct, data:data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
 static Future<ApiResponse> getFavourite() async {
    try {
      Response response = await DioHelper.getData(
          url: AppConstants.getFavourites,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

static Future<ApiResponse> getNotifications() async {
  try {
    Response response = await DioHelper.getData(
        url: AppConstants.getNotifications);
    return ApiResponse.withSuccess(response);
  } catch (e) {
    if (e.toString().contains("SocketException")) {
      return ApiResponse.withError("no internet");
    } else {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
static Future<ApiResponse> getSetting() async {
  try {
    Response response = await DioHelper.getData(
        url: AppConstants.getSettings);
    return ApiResponse.withSuccess(response);
  } catch (e) {
    if (e.toString().contains("SocketException")) {
      return ApiResponse.withError("no internet");
    } else {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
static Future<ApiResponse> readNotifications() async {
  try {
    Response response = await DioHelper.postData(
        url: AppConstants.make_notifications_read,data: {});
    return ApiResponse.withSuccess(response);
  } catch (e) {
    if (e.toString().contains("SocketException")) {
      return ApiResponse.withError("no internet");
    } else {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

  static Future<ApiResponse> getOrder() async {
    try {
      Response response = await DioHelper.getData(
          url: AppConstants.orders);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  } static Future<ApiResponse> getOrderDetails(int id) async {
    try {
      Response response = await DioHelper.getData(
          url: AppConstants.orders+"/$id");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return ApiResponse.withError("no internet");
      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
// static Future<ApiResponse> getDestinationPrograms(int id) async {
//   try {
//     Response response = await DioHelper.getData(
//         url: AppConstants.login);
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//     if (e.toString().contains("SocketException")) {
//       return ApiResponse.withError("no internet");
//     } else {
//       return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//     }
//   }
// }
// static Future<ApiResponse> getSingleProgram(int id) async {
//   try {
//     Response response = await DioHelper.getData(
//         url: AppConstants.login);
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//     if (e.toString().contains("SocketException")) {
//       return ApiResponse.withError("no internet");
//     } else {
//       return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//     }
//   }
// }
// static Future<ApiResponse> getSingleBlog(int id) async {
//   try {
//     Response response = await DioHelper.getData(
//         url: AppConstants.login);
//     return ApiResponse.withSuccess(response);
//   } catch (e) {
//     if (e.toString().contains("SocketException")) {
//       return ApiResponse.withError("no internet");
//     } else {
//       return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//     }
//   }
// }
//
//
}
