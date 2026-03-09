import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/model/home/favourite_response_model.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/repository/home_repository.dart';

class FavouriteCubit extends Cubit<FavouriteStates>{
  FavouriteCubit():super(AppInitFavouriteStates());
  static FavouriteCubit get(context)=>BlocProvider.of(context);
bool is_favourite_data= false;
  FavouriteResponseModel? favouriteResponseModel;
  getFavouriteApi(BuildContext context) async {
    // print(data);
    if(SharedPreferenceGetValue.getToken()==null||SharedPreferenceGetValue.getToken()==""){}else {
      try {
        is_favourite_data = true;
        emit(LoadingGetFavouriteStates());
        ApiResponse apiResponse = await HomeRepository.getFavourite();
        if (apiResponse.response != null &&
            apiResponse.response!.statusCode == 200) {
          is_favourite_data = false;
          favouriteResponseModel =
              FavouriteResponseModel.fromJson(apiResponse!.response!.data);
          emit(SuccessGetFavouriteStates());
        } else {
          try {
            appToast(message: apiResponse!.response!.data!["message"],
                type: ToastType.error,
                context: context);
          } catch (e) {
            appToast(
                message: e.toString(), type: ToastType.error, context: context);
          }
          is_favourite_data = false;
          emit(ErrorGetFavouriteStates());
        }
      } catch (e) {
        is_favourite_data = false;
        appToast(
            message: e.toString(), type: ToastType.error, context: context);
        emit(ErrorGetFavouriteStates());
      }
    }
  }

  addOrRemoveFavourite(BuildContext context, int productId) async {
    try {
      emit(LoadingAddFavouriteDataStates());
      ApiResponse apiResponse =
      await HomeRepository.addOrRemoveFavourite(productId);
      print("asdddddddd");
      print(apiResponse!.response!.data!.toString());
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        getFavouriteApi(context);
        emit(SuccessAddFavouriteDataStates());
      } else {
        emit(RemoveAddFavouriteDataStates());
      }
    } catch (e) {
      emit(RemoveAddFavouriteDataStates());
    }
  }
}
abstract class FavouriteStates{}
class AppInitFavouriteStates extends FavouriteStates {}
class LoadingGetFavouriteStates extends FavouriteStates {}
class SuccessGetFavouriteStates extends FavouriteStates {}
class ErrorGetFavouriteStates extends FavouriteStates {}
class LoadingAddFavouriteDataStates extends FavouriteStates {}
class SuccessAddFavouriteDataStates extends FavouriteStates {}
class RemoveAddFavouriteDataStates extends FavouriteStates {}