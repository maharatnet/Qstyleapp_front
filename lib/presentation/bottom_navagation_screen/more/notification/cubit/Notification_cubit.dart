import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/model/notification/notification_response_model.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navigation_cubit.dart';
import 'package:maharat_ecommerce/repository/home_repository.dart';

class NotificationCubit extends Cubit<NotificationStates>{
  NotificationCubit():super(AppInitNotificationState());
  static NotificationCubit get(context)=>BlocProvider.of(context);

  bool is_Notification_data = false;
  NotificationResponseModel? notificationResponseModel;

  getNotificationApi(BuildContext context) async {
    // print(data);
    try {
      is_Notification_data = true;
      emit(LoadingNotificationDataNewStates());
      ApiResponse apiResponse = await HomeRepository.getNotifications();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        is_Notification_data =false;
        notificationResponseModel = NotificationResponseModel.fromJson(apiResponse!.response!.data);
        readNotificationApi(context);
        emit(SuccessNotificationDataStates());
      } else {
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }
        is_Notification_data =false;
        emit(ErrorNotificationDataStates());
      }
    }catch(e){
      is_Notification_data =false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorNotificationDataStates());
    }
  }
readNotificationApi(BuildContext context) async {
    // print(data);
    try {
      // is_Notification_data = true;
      emit(LoadingReadNotificationDataStates());
      ApiResponse apiResponse = await HomeRepository.readNotifications();
      print("apiResponse.toString()");
      print(apiResponse.toString());
      print(apiResponse.response.toString());
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
      BottomNavigationCubit.get(context).getNotificationApi(context);
        emit(SuccessReadNotificationDataStates());
      } else {
        try {
          // appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          // appToast(message: e.toString(), type: ToastType.error, context: context);

        }
        // is_Notification_data =false;
        emit(ErrorReadNotificationDataStates());
      }
    }catch(e){
      // is_Notification_data =false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorReadNotificationDataStates());
    }
  }


}
abstract class NotificationStates {}
class AppInitNotificationState extends NotificationStates {}
// class LoadingNotificationDataStates extends NotificationStates {}
class LoadingNotificationDataNewStates extends NotificationStates {}
class SuccessNotificationDataStates extends NotificationStates {}
class ErrorNotificationDataStates extends NotificationStates {}
class LoadingReadNotificationDataStates extends NotificationStates {}
class SuccessReadNotificationDataStates extends NotificationStates {}
class ErrorReadNotificationDataStates extends NotificationStates {}