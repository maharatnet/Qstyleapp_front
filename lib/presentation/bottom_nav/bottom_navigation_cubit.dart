import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/model/app_setting_response.dart';
import 'package:maharat_ecommerce/model/home/banner_response_model.dart';
import 'package:maharat_ecommerce/model/home/category_response_model.dart';
import 'package:maharat_ecommerce/model/notification/notification_response_model.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/cart/cart_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/favourite/favourite_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/home_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/profile/profile_screen.dart';
import 'package:maharat_ecommerce/repository/home_repository.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationStates>{
  BottomNavigationCubit():super(AppInitBottomNavigationState());
  static BottomNavigationCubit get(context)=>BlocProvider.of(context);

  final pages = [
    const HomeScreen(),
    const FavouriteScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];
  int startIndex =0;
  void updateCurrentIndex(int index) {
    // setState(() {
      startIndex = index;
      // currentSelectedIndex = index;
    // });
    emit(RefreshBottomNavigationState());
  }
  void updateCurrentIndexBrand(int index,BuildContext context) {
    // setState(() {
      startIndex = index;
      navigateAndFinish(context, BottomNavigationScreen(startIndex: index,));
      // currentSelectedIndex = index;
    // });
    emit(RefreshBottomNavigationState());
  }
  void refreshData(){
    emit(RefreshBottomNavigationState());
  }

bool is_banner_data = false;
bool is_category_data = false;
  BannerResponseModel ?bannerResponseModel;
  CategoryResponseModel? categoryResponseModel;
  getBannerApi(BuildContext context, ) async {
    // print(data);
    try {
      is_banner_data = true;
      emit(LoadingBannerDataStates());
      ApiResponse apiResponse = await HomeRepository.getBanners();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        // print("apiResponse.response!.data.toString()");
        // print(apiResponse.response!.data.toString());
        is_banner_data =false;
        bannerResponseModel = BannerResponseModel.fromJson(apiResponse!.response!.data);
        emit(SuccessBannerDataStates());
      } else {
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }
        is_banner_data =false;
        emit(ErrorBannerDataStates());
      }
    }catch(e){
      is_banner_data =false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorBannerDataStates());
    }
  }
  List<CategoryModel>? categoryList = [];
  getCategoryApi(BuildContext context,int international) async {
    // print(data);
    try {
      is_category_data = true;
      emit(LoadingCategoryDataStates());
      ApiResponse apiResponse = await HomeRepository.getCategory();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        is_category_data =false;
        categoryList = [];
        categoryResponseModel = CategoryResponseModel.fromJson(apiResponse!.response!.data);
        // final filteredList = categoryResponseModel?.data
        //     ?.where((e) => e.subcategories.is_international == international)
        //     .toList();
        // final filteredList =
        // ✅ فلترة السب كاتيجوري حسب isInternational
        final filteredList = categoryResponseModel?.data
            ?.map((category) {
          final filteredSubcategories = category.subcategories
              ?.where((subcategory) => subcategory.is_international == international)
              .toList();

          // إذا مفيش ولا subcategory مطابقة، إحذف الكاتيجوري
          if (filteredSubcategories == null || filteredSubcategories.isEmpty) {
            return null;
          }

          // ارجع نسخة جديدة من الكاتيجوري مع السبكاتيجوري المفلترة
          return CategoryModel(
            id: category.id,
            name: category.name,
            image: category.image,
            // باقي الخصائص هنا حسب الموديل عندك
            subcategories: filteredSubcategories,
          );
        })
            .where((category) => category != null)
            .cast<CategoryModel>()
            .toList();

        if (filteredList != null) {
          categoryList!.addAll(filteredList);
        }
        // if (filteredList != null) {
        //   categoryList.addAll(filteredList as Iterable<CategoryModel>);
        // }

        // categoryList.addAll(categoryResponseModel!.data!.where((e)=>e.is_international==international).toList());
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
  bool is_Notification_data = false;
  AppSettingsResponse? appSettingsResponse;
  List<CountriesModel> countryList = [];
  getNotificationApi(BuildContext context) async {
    if(SharedPreferenceGetValue.getToken()==null||SharedPreferenceGetValue.getToken()==""){}else {
      // print(data);
      try {
        is_Notification_data = true;
        emit(LoadingNotificationDataStates());
        ApiResponse apiResponse = await HomeRepository.getSetting();
        if (apiResponse.response != null &&
            apiResponse.response!.statusCode == 200) {
          is_Notification_data = false;
          // print("apiResponse!.response!.data");
          // print(apiResponse!.response!.data!.toString());
          appSettingsResponse =
              AppSettingsResponse.fromJson(apiResponse!.response!.data);
          if(appSettingsResponse!=null&&appSettingsResponse!.data!=null&&appSettingsResponse!.data!.countries!=null){
            countryList.addAll(appSettingsResponse!.data!.countries!);
          }
          emit(SuccessNotificationDataStates());
        } else {
          try {
            appToast(message: apiResponse!.response!.data!["message"],
                type: ToastType.error,
                context: context);
          } catch (e) {
            appToast(
                message: e.toString(), type: ToastType.error, context: context);
          }
          is_Notification_data = false;
          emit(ErrorNotificationDataStates());
        }
      } catch (e) {
        is_Notification_data = false;
        appToast(
            message: e.toString(), type: ToastType.error, context: context);
        emit(ErrorNotificationDataStates());
      }
    }
  }


}
abstract class BottomNavigationStates {}
class AppInitBottomNavigationState extends BottomNavigationStates {}
class RefreshBottomNavigationState extends BottomNavigationStates {}
class LoadingBannerDataStates extends BottomNavigationStates {}
class SuccessBannerDataStates extends BottomNavigationStates {}
class ErrorBannerDataStates extends BottomNavigationStates {}
class LoadingCategoryDataStates extends BottomNavigationStates {}
class SuccessCategoryDataStates extends BottomNavigationStates {}
class ErrorCategoryDataStates extends BottomNavigationStates {}
class LoadingNotificationDataStates extends BottomNavigationStates {}
class SuccessNotificationDataStates extends BottomNavigationStates {}
class ErrorNotificationDataStates extends BottomNavigationStates {}
