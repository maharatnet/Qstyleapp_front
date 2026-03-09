import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/model/home/catgory_product_reponse_model.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/category_item_screen.dart';
import 'package:maharat_ecommerce/repository/home_repository.dart';

class CategoryItemCubit extends Cubit<CategoryItemStates>{
  CategoryItemCubit():super(AppInitCategoryItemStates());
  static CategoryItemCubit get(context)=>BlocProvider.of(context);

  String searchQuery = "";
  String selectedFilter = "All";
  // List<CategoryProductResponseModel> filteredList = dataListItems;
  List<CategoryProductModel> filteredList = [];
  List<String> selectedFilters = []; // للحفاظ على الاختيارات المتعددة

  // void updateFilters(String query) {
  //   if (categoryProductModel?.data == null) return;
  //
  //   final lowerQuery = query.toLowerCase();
  //
  //   // فلترة بناءً على البحث والفلاتر كلها مرة واحدة
  //   filteredList = categoryProductModel!.data!
  //       .where((item) {
  //     final name = item.name?.toLowerCase() ?? '';
  //     final price = item.price ?? 0;
  //     final discountPrice = item.discountPrice ?? 0;
  //
  //     // البحث بالاسم
  //     bool matchesSearch = name.contains(lowerQuery);
  //
  //     // فلتر الخصم
  //     bool matchesDiscount = !selectedFilters.contains("Discounted") || discountPrice < price;
  //
  //     return matchesSearch && matchesDiscount;
  //   })
  //       .toList();
  //
  //   // ترتيب حسب السعر
  //   if (selectedFilters.contains("Highest Price")) {
  //     filteredList.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
  //   } else if (selectedFilters.contains("Lowest Price")) {
  //     filteredList.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
  //   }
  //
  //   emit(RefreshCategoryItemStates());
  // }

  // // فلترة حسب السعر أو الخصومات أو البراندات
  // void updateFilters(String query) {
  //   // setState(() {
  //     filteredList = categoryProductModel!.data!
  //         .where((item) {
  //       bool matchesSearch = item.name!.toLowerCase().contains(query.toLowerCase());
  //
  //       // تحقق من الفلاتر
  //       bool matchesFilter = true;
  //       if (selectedFilters.contains("Highest Price") && item.price! <= 100) {
  //         matchesFilter = false;
  //       }
  //       if (selectedFilters.contains("Lowest Price") && item.price! >= 200) {
  //         matchesFilter = false;
  //       }
  //       if (selectedFilters.contains("Discounted") && item.discountPrice! <= 0) {
  //         matchesFilter = false;
  //       }
  //       // if (selectedFilters.contains("brand") && item!.brand != "brand") {
  //       //   matchesFilter = false;
  //       // }
  //
  //       return matchesSearch && matchesFilter;
  //     })
  //         .toList();
  //   // });
  //   emit(RefreshCategoryItemStates());
  // }

void refreshData(){
    emit(RefreshCategoryItemStates());
}

  bool is_category_data = false;
  CategoryProductResponseModel? categoryProductModel;
  getCategoryApi(BuildContext context, int categoryID, int is_international) async {
    print("categoryID");
    print(categoryID);
    try {
      is_category_data = true;
      emit(LoadingCategoryDataStates());
      ApiResponse apiResponse = await HomeRepository.getCategoryProduct(categoryID,is_international);

      print("apiResponse.response!.data.toString()");
      print(apiResponse.response!.data.toString());
      print(apiResponse.response!.data.toString());
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        is_category_data =false;
        categoryProductModel = CategoryProductResponseModel.fromJson(apiResponse!.response!.data);

        filteredList.addAll(categoryProductModel!.data!);
        emit(SuccessCategoryDataStates());
      } else {
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }
        is_category_data =false;
        emit(ErrorCategoryDataStates());
      }
    }catch(e){
      is_category_data =false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorCategoryDataStates());
    }
  }
  ///000000
// إضافة هذه المتغيرات في CategoryItemCubit
  int? selectedBrandId;

// إضافة هذه الدالة في CategoryItemCubit
  void updateBrandFilter(int? brandId) {
    selectedBrandId = brandId;
    print("selectedBrandId ${selectedBrandId}");
    updateFilters(searchQuery);
    emit(CategoryItemRefreshState());
  }

// تحديث دالة updateFilters لتشمل فلترة البراند
  void updateFilters(String query) {
    searchQuery = query;
    filteredList = categoryProductModel?.data ?? [];

    // فلترة بالبحث
    if (query.isNotEmpty) {
      filteredList = filteredList.where((item) {
        return (item.name?.toLowerCase().contains(query.toLowerCase()) ?? false);
      }).toList();
    }

    // فلترة بالبراند
    if (selectedBrandId != null) {
      filteredList = filteredList.where((item) {
        // print(item.toJson());
        // print(item.brand!.toJson());
        return item!.brand!=null&&item!.brand!.id == selectedBrandId; // تأكد من وجود brandId في ProductModel
      }).toList();
    }
    if (selectedFilters.contains('international')) {
      filteredList = filteredList.where((item) {
        // print("item.brand.toJson()");
        // print(item.toJson());
        // print(item.brand!.toJson());
        return item!.brand!.isInterantional ==1; // تأكد من وجود brandId في ProductModel
      }).toList();
    }
    // فلترة بالسعر والخصم
    if (selectedFilters.contains('Highest Price')) {
      try {
        if (selectedFilters.contains('Lowest Price')) {
          selectedFilters.remove('Lowest Price');
        }
      }catch(e){

      }
      filteredList.sort((a, b) {
        double priceA = a.discountPrice != null && double.parse(a.discountPrice??"0.0") > 0
        // double priceA = a.discountPrice != null && a.discountPrice! > 0
            ? double.parse(a.discountPrice??"0.0")
            // ? a.discountPrice!.toDouble()
            : double.parse(a.price??"0.0") ?? 0;
            // : a.price?.toDouble() ?? 0;
        double priceB = b.discountPrice != null && double.parse(b.discountPrice??"0.0") > 0
        // double priceB = b.discountPrice != null && b.discountPrice! > 0
            ? double.parse(b.discountPrice??"0.0")
            // ? b.discountPrice!.toDouble()
            : double.parse(b.price??"0.0") ?? 0;
            // : b.price?.toDouble() ?? 0;
        return priceB.compareTo(priceA);
      });
    }

    if (selectedFilters.contains('Lowest Price')) {
      try {
        if (selectedFilters.contains('Highest Price')) {
          selectedFilters.remove('Highest Price');
        }
      }catch(e){

      }
      filteredList.sort((a, b) {
        double priceA = a.discountPrice != null && double.parse(a.discountPrice??"0.0") > 0
        // double priceA = a.discountPrice != null && a.discountPrice! > 0
            ? double.parse(a.discountPrice??"0.0")//.toDouble()
            : double.parse(a.price??"0.0") ?? 0;
            // : a.price?.toDouble() ?? 0;
        double priceB = b.discountPrice != null && double.parse(b.discountPrice??"0.0") > 0
        // double priceB = b.discountPrice != null && b.discountPrice! > 0
            ? double.parse(b.discountPrice??"0.0")//!.toDouble()
            : double.parse(b.price??"0.0") ?? 0;
            // : b.price?.toDouble() ?? 0;
        return priceA.compareTo(priceB);
      });
    }

    if (selectedFilters.contains('Discounted')) {
      filteredList = filteredList.where((item) {
        return item.discountPrice != null && double.parse(item.discountPrice??"0.0") > 0;
        // return item.discountPrice != null && item.discountPrice! > 0;
      }).toList();
    }

    emit(CategoryItemRefreshState());
  }

}
abstract class CategoryItemStates {}
class AppInitCategoryItemStates extends CategoryItemStates {}
class RefreshCategoryItemStates extends CategoryItemStates {}
class LoadingCategoryDataStates extends CategoryItemStates {}
class SuccessCategoryDataStates extends CategoryItemStates {}
class ErrorCategoryDataStates extends CategoryItemStates {}
class CategoryItemRefreshState extends CategoryItemStates {}
