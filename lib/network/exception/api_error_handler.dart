import 'package:maharat_ecommerce/network/exception/error_response.dart';
import 'package:dio/dio.dart';
// import 'package:uber/network/exception/error_response.dart';
import 'package:flutter/material.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioErrorType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioErrorType.unknown:
              errorDescription =
              "Connection to API server failed due to internet connection";
              break;
            case DioErrorType.receiveTimeout:
              errorDescription =
              "Receive timeout in connection with API server";
              break;

            case DioErrorType.badResponse:
              switch (error.response!.statusCode) {
                case 403:
                  debugPrint('<==Here is error body==${error.response!.data.toString()}===>');
                  if(error.response!.data['errors'] != null){
                    errorDescription = error.response!.data['errors'][0];
                  }else{
                    errorDescription = error.response!.data['message'];
                  }
                  break;
                case 404:
                case 500:
                case 503:
                case 429:
                  errorDescription = error.response!.statusMessage;
                  break;
                default:
                  ErrorResponse errorResponse =
                  ErrorResponse.fromJson(error.response!.data);
                  if (errorResponse.errors != null &&
                      errorResponse.errors!.isNotEmpty) {
                    errorDescription = errorResponse;
                  } else {
                    errorDescription =
                    "Failed to load data - status code: ${error.response!.statusCode}";
                  }
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
            case DioExceptionType.badCertificate:
              // TODO: Handle this case.
            case DioExceptionType.connectionError:
              // TODO: Handle this case.
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
