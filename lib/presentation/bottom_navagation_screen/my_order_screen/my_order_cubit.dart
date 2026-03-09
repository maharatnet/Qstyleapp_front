import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/model/order/order_details_response_model.dart';
import 'package:maharat_ecommerce/model/order/order_response_model.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/repository/home_repository.dart';

class MyOrderCubit extends Cubit<MyOrderStates>{
  MyOrderCubit():super(AppInitMyOrderState());
static MyOrderCubit get(context)=>BlocProvider.of(context);

  OrderResponseModel?orderResponseModel;

bool is_get_data = false;
  getOrderApi(BuildContext context) async {
    // print(data);
    try {
      is_get_data = true;
      emit(LoadingOrderDataStates());
      ApiResponse apiResponse = await HomeRepository.getOrder();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        is_get_data =false;
        orderResponseModel = OrderResponseModel.fromJson(apiResponse!.response!.data);
        emit(SuccessOrderDataStates());
      } else {
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }
        is_get_data =false;
        emit(ErrorOrderDataStates());
      }
    }catch(e){
      is_get_data =false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorOrderDataStates());
    }
  }
  OrderDetailsResponseModel?orderDetailsResponseModel;
  getOrderDetailsApi(BuildContext context,int? orderId) async {
    try {
      emit(LoadingOrderDetailsDataStates());
      ApiResponse apiResponse = await HomeRepository.getOrderDetails(orderId??1);
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        orderDetailsResponseModel = OrderDetailsResponseModel.fromJson(apiResponse!.response!.data);
        emit(SuccessOrderDetailsDataStates());
      } else {
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }
        emit(ErrorOrderDetailsDataStates());
      }
    }catch(e){
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorOrderDetailsDataStates());
    }
  }


}
abstract class MyOrderStates {}
class AppInitMyOrderState extends MyOrderStates {}
class LoadingOrderDataStates extends MyOrderStates {}
class SuccessOrderDataStates extends MyOrderStates {}
class ErrorOrderDataStates extends MyOrderStates {}
class LoadingOrderDetailsDataStates extends MyOrderStates {}
class SuccessOrderDetailsDataStates extends MyOrderStates {}
class ErrorOrderDetailsDataStates extends MyOrderStates {}