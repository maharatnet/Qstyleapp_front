import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/model/home/show_products_response_model.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'package:maharat_ecommerce/repository/cart_repository.dart';
import 'package:maharat_ecommerce/repository/home_repository.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsStates> {
  CategoryDetailsCubit() : super(AppInitCategoryDetailsState());

  static CategoryDetailsCubit get(context) => BlocProvider.of(context);
  int selectedColorIndex = 0;
  int quantity = 1;

  SizeModel? sizeSelect;
  ColorModel? colorModel;

  ShowSingleProductResponseModel? showProductModel;
  bool is_category_data = false;
int show_product =0;
  getCategoryProductApi(BuildContext context, int productId) async {
    // print(data);
    try {
      show_product = 0;
      is_category_data = true;
      emit(LoadingCategoryDataStates());
      ApiResponse apiResponse =
          await HomeRepository.getProductDetails(productId);
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        print("apiadsasdas");
        print(apiResponse!.response!.data!.toString());
        is_category_data = false;
        showProductModel = ShowSingleProductResponseModel.fromJson(
            apiResponse!.response!.data);
        if (showProductModel != null &&
            showProductModel!.data != null &&
            showProductModel!.data!.sizes != null &&
            showProductModel!.data!.sizes!.length > 0) {
          sizeSelect = showProductModel!.data!.sizes![0];
        }
        if (showProductModel != null &&
            showProductModel!.data != null &&
            showProductModel!.data!.colors != null &&
            showProductModel!.data!.colors!.length > 0) {
          colorModel = showProductModel!.data!.colors![0];
        }
        try {
          Map<String, dynamic> checkData = {
            "product_id": productId,
            "quantity": quantity,
          };

          if (sizeSelect != null) {
            checkData["size_id"] = sizeSelect!.id ?? 1;
          }

          if (colorModel != null) {
            checkData["color_id"] = colorModel!.id ?? 1;
          }
          checkProduct(context, checkData);
        }catch(e){

        }
        emit(SuccessCategoryDataStates());
      } else {
        try {
          appToast(
              message: apiResponse!.response!.data!["message"],
              type: ToastType.error,
              context: context);
        } catch (e) {
          appToast(
              message: e.toString(), type: ToastType.error, context: context);
        }
        is_category_data = false;
        emit(ErrorCategoryDataStates());
      }
    } catch (e) {
      print(e.toString());
      is_category_data = false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorCategoryDataStates());
    }
  }

  refreshData() {
    emit(CategoryDetailsRefreshState());
  }

  addOrRemoveFavourite(BuildContext context, int productId) async {
    try {
      print("productIdproductId");
      print(productId);
      emit(LoadingAddFavouriteDataStates());
      ApiResponse apiResponse =
          await HomeRepository.addOrRemoveFavourite(productId);
      print("asdddddddd");
      print(apiResponse!.response!.data!.toString());
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        if (showProductModel!.data!.added_to_favouries == 0) {
          showProductModel!.data!.added_to_favouries = 1;
        } else {
          showProductModel!.data!.added_to_favouries = 0;
        }
        emit(SuccessAddFavouriteDataStates());
      } else {
        emit(RemoveAddFavouriteDataStates());
      }
    } catch (e) {
      emit(RemoveAddFavouriteDataStates());
    }
  }

  // إضافة متغير حالة التوفر
  bool isProductAvailable = true;
  String? availabilityMessage;

  // الدوال الموجودة...
  // void refreshData() {
  //   emit(CategoryDetailsRefreshState());
  // }
  checkProduct(BuildContext context, Map<String,dynamic> data) async {
    try {
      // print("productIdproductId");
      // print(productId);
      emit(LoadingCheckProductDataStates());
      ApiResponse apiResponse =
          await HomeRepository.checkProduct(data);
      print(apiResponse!.response!.data);
      print(apiResponse!.response!.data);
      print(apiResponse!.response!.data["data"]??"");
      print(apiResponse!.response!.data["status"]??"");
      if (apiResponse!.response!.statusCode == 200) {
        final responseData = apiResponse!.response!.data;

        // تحديث حالة التوفر بناءً على الاستجابة
        if (responseData['status'] == true && responseData['code'] == "200") {
          isProductAvailable =  true;
          availabilityMessage = responseData['message'] ?? '';

          // إذا كان المنتج غير متوفر، أرسل حالة خاصة
          if (!isProductAvailable) {
            emit(ProductAvailabilityCheckedState(isAvailable: false, message: availabilityMessage));
          } else {
            emit(ProductAvailabilityCheckedState(isAvailable: true, message: availabilityMessage));
          }
        } else {
          // في حالة فشل الاستجابة
          isProductAvailable = false;
          availabilityMessage = responseData['message'] ?? 'Product not available';
          emit(ProductAvailabilityCheckedState(isAvailable: false, message: availabilityMessage));
        }
      } else {
        // في حالة خطأ في الشبكة
        isProductAvailable = false;
        availabilityMessage = 'Error checking availability';
        emit(ProductAvailabilityErrorState(error: 'Network error'));
      }
    } catch (error) {
      print('Error checking product availability: $error');
      isProductAvailable = false;
      availabilityMessage = 'Error checking availability';
      emit(ProductAvailabilityErrorState(error: error.toString()));
    }
      // print("asdddddddd");
      // print(apiResponse!.response!.data!.toString());
      // if (apiResponse.response != null &&
      //     apiResponse.response!.statusCode == 200) {
      //   // if (showProductModel!.data!.added_to_favouries == 0) {
      //   //   showProductModel!.data!.added_to_favouries = 1;
      //   // } else {
      //   //   showProductModel!.data!.added_to_favouries = 0;
      //   // }
      //   emit(SuccessCheckProductDataStates());
      // } else {
      //   emit(RemoveCheckProductDataStates());
      // }
    // } catch (e) {
    //   emit(RemoveCheckProductDataStates());
    // }
  }

  addCart(BuildContext context, Map<String, dynamic> data) async {
    try {
      print("data");
      print(data);
      emit(LoadingAddCartDataStates());
      ApiResponse apiResponse = await CartRepository.addCart(data);
      print("apiResponse");
      print(apiResponse!.response!.toString());
      print(apiResponse!.response!.data!.toString());

      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        if(apiResponse.response!.data!["status"]) {
          navigateAndFinish(
              context,
              BottomNavigationScreen(
                startIndex: 2,
              ));
        }else{
          appToast(message: apiResponse.response!.data!["message"], type: ToastType.error, context: context);

        }
        emit(SuccessAddCartDataStates());
      } else {
        emit(RemoveAddCartDataStates());
      }
    } catch (e) {
      print(e.toString());
      appToast(message: e.toString(), type: ToastType.error, context: context);

      emit(RemoveAddCartDataStates());
    }
  }
}

abstract class CategoryDetailsStates {}

class AppInitCategoryDetailsState extends CategoryDetailsStates {}

class LoadingCategoryDataStates extends CategoryDetailsStates {}

class SuccessCategoryDataStates extends CategoryDetailsStates {}

class ErrorCategoryDataStates extends CategoryDetailsStates {}

class RefreshDataCategoryDataStates extends CategoryDetailsStates {}

class LoadingAddFavouriteDataStates extends CategoryDetailsStates {}

class SuccessAddFavouriteDataStates extends CategoryDetailsStates {}

class RemoveAddFavouriteDataStates extends CategoryDetailsStates {}

class LoadingAddCartDataStates extends CategoryDetailsStates {}

class SuccessAddCartDataStates extends CategoryDetailsStates {}

class RemoveAddCartDataStates extends CategoryDetailsStates {}
class LoadingCheckProductDataStates extends CategoryDetailsStates {}

class SuccessCheckProductDataStates extends CategoryDetailsStates {}

class RemoveCheckProductDataStates extends CategoryDetailsStates {}
class CategoryDetailsRefreshState extends CategoryDetailsStates {}
class LoadingProductAvailabilityState extends CategoryDetailsStates {}

class ProductAvailabilityCheckedState extends CategoryDetailsStates {
  final bool isAvailable;
  final String? message;

  ProductAvailabilityCheckedState({
    required this.isAvailable,
    this.message
  });
}

class ProductAvailabilityErrorState extends CategoryDetailsStates {
  final String error;
  ProductAvailabilityErrorState({required this.error});
}