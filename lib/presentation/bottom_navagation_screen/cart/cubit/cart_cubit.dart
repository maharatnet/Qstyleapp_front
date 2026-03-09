import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/model/address/address_response_model.dart';
import 'package:maharat_ecommerce/model/cart/cart_response_model.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/repository/cart_repository.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
class CartCubit extends Cubit<CartStates>{
  CartCubit():super(AppInitCartState());
static CartCubit get(context)=>BlocProvider.of(context);
 bool is_get_data = false;
  CartResponseModel?cartResponseModel;
  AddressModel? addressModel;
  getCartApi(BuildContext context) async {
    // print(data);
    if(SharedPreferenceGetValue.getToken()==null||SharedPreferenceGetValue.getToken()==""){}else {
      try {
        is_get_data = true;
        emit(LoadingGetCartState());
        ApiResponse apiResponse = await CartRepository.getCart();
        if (apiResponse.response != null &&
            apiResponse.response!.statusCode == 200) {
          print("apiResponse.response");
          print(apiResponse.response!.data.toString());
          is_get_data = false;
          cartResponseModel =
              CartResponseModel.fromJson(apiResponse!.response!.data);
          emit(SuccessGetCartState());
        } else {
          try {
            appToast(message: apiResponse!.response!.data!["message"],
                type: ToastType.error,
                context: context);
          } catch (e) {
            appToast(
                message: e.toString(), type: ToastType.error, context: context);
          }
          is_get_data = false;
          emit(ErrorGetCartState());
        }
      } catch (e) {
        is_get_data = false;
        appToast(
            message: e.toString(), type: ToastType.error, context: context);
        emit(ErrorGetCartState());
      }
    }
  }
  getCartApiTwo(BuildContext context,int address_id) async {
    // print(data);
    if(SharedPreferenceGetValue.getToken()==null||SharedPreferenceGetValue.getToken()==""){}else {
      try {
        is_get_data = true;
        emit(LoadingGetCartState());
        print("address --- ${address_id}");
        ApiResponse apiResponse = await CartRepository.getCart(address_id: address_id);
        if (apiResponse.response != null &&
            apiResponse.response!.statusCode == 200) {
          // print("apiResponse.response");
          // print(apiResponse.response!.data.toString());
          is_get_data = false;
          cartResponseModel =
              CartResponseModel.fromJson(apiResponse!.response!.data);
          emit(SuccessGetCartState());
        } else {
          try {
            appToast(message: apiResponse!.response!.data!["message"],
                type: ToastType.error,
                context: context);
          } catch (e) {
            appToast(
                message: e.toString(), type: ToastType.error, context: context);
          }
          is_get_data = false;
          emit(ErrorGetCartState());
        }
      } catch (e) {
        is_get_data = false;
        appToast(
            message: e.toString(), type: ToastType.error, context: context);
        emit(ErrorGetCartState());
      }
    }
  }
  bool is_update = false;
  updateCartApi(BuildContext context, int cartId,String qty,Function() onTap) async {

    try {
      // is_get_data = true;
      is_update = true;
      print("qty00000 $qty");
      emit(LoadingUpdateCartState());
      ApiResponse apiResponse = await CartRepository.updateCart(cartId,{
        "quantity":qty
      });
      print("apisddasdas");
      print(apiResponse!.response!.data!.toString());
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        if(apiResponse.response!.data!["status"]) {
          // cartResponseModel = CartResponseModel.fromJson(apiResponse!.response!.data);
          onTap();
          try {
            ApiResponse apiResponse = await CartRepository.getCart();
            if (apiResponse.response != null &&
                apiResponse.response!.statusCode == 200) {
              is_get_data = false;
              cartResponseModel =
                  CartResponseModel.fromJson(apiResponse!.response!.data);
              emit(SuccessUpdateCartState());
            }
          }catch(e){

          }
          // navigateAndFinish(
          //     context,
          //     BottomNavigationScreen(
          //       startIndex: 2,
          //     ));
          is_update = false;
        }else{
          appToast(message: apiResponse.response!.data!["message"], type: ToastType.error, context: context);
          is_update = false;
        }
        // is_get_data =false;
        // cartResponseModel = CartResponseModel.fromJson(apiResponse!.response!.data);
        emit(SuccessUpdateCartState());
      } else {
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }
        is_update = false;
        // is_get_data =false;
        emit(ErrorUpdateCartState());
      }
    }catch(e){
      // is_get_data =false;
      is_update = false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorUpdateCartState());
    }
  }
  addOrdersApi(BuildContext context, Map<String,dynamic> data) async {

    try {
      // is_get_data = true;
      emit(LoadingAddOrdersState());
      ApiResponse apiResponse = await CartRepository.addOrders(data);
      print(apiResponse!.response!.data!.toString());
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        getCartApi(context);
      } else {
        try {
          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);

        }
        // is_get_data =false;
        emit(ErrorAddOrdersState());
      }
    }catch(e){
      // is_get_data =false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorAddOrdersState());
    }
  }

 Future<bool> deleteCartApi(BuildContext context, int cartId) async {
    // print(data);
    try {
      // is_get_data = true;
      emit(LoadingUpdateCartState());
      ApiResponse apiResponse = await CartRepository.deleteCart(cartId);
      print("apieadddddddsa");
      print(apiResponse.response!.data.toString());
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        // getCartApi(context);
        if(apiResponse.response!.data!["status"]) {
          return true;
        }else{
          return false;
        }
        emit(SuccessUpdateCartState());
      } else {
        try {

          appToast(message: apiResponse!.response!.data!["message"], type: ToastType.error, context: context);
          return false;
        }catch(e){
          appToast(message: e.toString(), type: ToastType.error, context: context);
          return false;
        }

        // is_get_data =false;
        emit(ErrorUpdateCartState());
      }
    }catch(e){
      // is_get_data =false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorUpdateCartState());
      return false;
    }
  }
  void refreshData(){
    emit(RefreshDataCartState());
  }
  //// 0000000000000000000 //
  String paymentId ="";
  bool is_wait_create = false;
  createPaymentIntent(String amount, String currency,BuildContext context) async {
    try {
      is_wait_create = true;
      refreshData();
      //Request body
      Map<String, dynamic> body = {
        'amount': "$amount",
        'currency': "$currency",
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': '',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      is_wait_create = false;
      refreshData();
      print("😂😂😂😂😂😂😂😂😂😂");
      print(json.decode(response.body));
      if(json.decode(response.body).toString().contains("error:")){
        try{
          appToast(message: json.decode(response.body)["error"]["message"].toString(), type: ToastType.error, context: context);

        }catch(e){

        }
      }
      print("😂😂😂😂😂😂😂😂😂😂");
      await Stripe.instance
          .initPaymentSheet(

          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: json.decode(response.body)!['client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'Ikay'))
          .then((value) {

        print("HHAHHAHAHAHHAHAHHA");
      });
      print("response.body");
      paymentId = json.decode(response.body)["id"];
      print(json.decode(response.body)["id"]);
      print(response.body);
      print(response.headers);
      print(response.headersSplitValues);

      //STEP 3: Display Payment sheet
      // displayPaymentSheet(context,paymentId);
      displayPaymentSheet(context);

      return json.decode(response.body);
    } catch (err) {
      appToast(message: err.toString(), type: ToastType.error, context: context);

      throw Exception(err.toString());
    }
  }
  // displayPaymentSheet(context, String paymentId) async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet().then((value) async {
  //       // ✅ بعد نجاح الدفع، نجيب بيانات العملية من Stripe
  //       var response = await http.get(
  //         Uri.parse('https://api.stripe.com/v1/payment_intents/$paymentId'),
  //         headers: {
  //           'Authorization':
  //      '',
  //         },
  //       );
  //
  //       print("responsebodyFinish");
  //       print(response.body);
  //       var paymentDetails = json.decode(response.body);
  //
  //       // ✅ هات نوع وسيلة الدفع
  //       var paymentMethod = paymentDetails["charges"]["data"][0]["payment_method_details"];
  //       var brand = paymentMethod["card"]["brand"];
  //       var last4 = paymentMethod["card"]["last4"];
  //
  //       print("✅ تمت العملية باستخدام كارت: $brand ****$last4");
  //       print("✅ PaymentIntent ID: $paymentId");
  //
  //       showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(Icons.check_circle, color: Colors.green, size: 100),
  //               SizedBox(height: 10),
  //               Text("تم الدفع بنجاح"),
  //               Text("الكارت: $brand ****$last4"),
  //               Text("رقم العملية: $paymentId"),
  //             ],
  //           ),
  //         ),
  //       );
  //     });
  //   } on StripeException catch (e) {
  //     print('❌ StripeException: $e');
  //     AlertDialog(
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Row(
  //             children: const [
  //               Icon(
  //                 Icons.cancel,
  //                 color: Colors.red,
  //                 // color: Colors.red,
  //               ),
  //               Text("Payment Failed"),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
  //   } catch (e) {
  //     print('❌ Error: $e');
  //   }
  // }

  displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet(
          options: PaymentSheetPresentOptions()
      ).then((value)async {
        ApiResponse apiResponse = await CartRepository.addOrders({
          "address_id":addressModel!.id??1,
          "payment_method":"visa",
          "payment_status":1,
          "payment_id":paymentId,
        });
        print(apiResponse!.response!.data!.toString());
        if (apiResponse.response != null &&
            apiResponse.response!.statusCode == 200) {
          getCartApi(context);
          showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text(value!.label??""),
                        // Text("${value!.toJson()}"),
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          // color: Colors.green,
                          size: 100.0,
                        ),
                        SizedBox(height: 10.0),
                        Text(apiResponse!.response!.data!["message"]??"Payment Successful!"),
                        // Text("Payment Successful!"),
                      ],
                    ),
                  ));
        }else{
          try {
            appToast(message: apiResponse!.response!.data!["message"] ?? "",
                type: ToastType.error,
                context: context);
          }catch(e) {
            appToast(message:"Error !", type: ToastType.error, context: context);
          }
        }
        // paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      ApiResponse apiResponse = await CartRepository.addOrders({
        "address_id":addressModel!.id??1,
        "payment_method":"visa",
        "payment_status":2,
        "payment_id":paymentId,
      });
      print(apiResponse!.response!.data!.toString());
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                    // color: Colors.red,
                  ),
                  Text("Payment Failed"),
                ],
              ),
            ],
          ),
        );
      }{
        try {
          appToast(message: apiResponse!.response!.data!["message"] ?? "",
              type: ToastType.error,
              context: context);
        }catch(e) {
          appToast(message:"Error !", type: ToastType.error, context: context);
        }
      }
    } catch (e) {
      print('$e');
    }
  }
}
abstract class CartStates {}
class AppInitCartState extends CartStates {}
class LoadingGetCartState extends CartStates {}
class SuccessGetCartState extends CartStates {}
class ErrorGetCartState extends CartStates {}
class LoadingUpdateCartState extends CartStates {}
class SuccessUpdateCartState extends CartStates {}
class ErrorUpdateCartState extends CartStates {}
class LoadingDeleteCartState extends CartStates {}
class SuccessDeleteCartState extends CartStates {}
class ErrorDeleteCartState extends CartStates {}
class RefreshDataCartState extends CartStates {}
class LoadingAddOrdersState extends CartStates {}
class ErrorAddOrdersState extends CartStates {}
// class ErrorAddOrdersState extends CartStates {}
//