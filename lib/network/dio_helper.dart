import 'package:maharat_ecommerce/component/app_constants.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:dio/dio.dart';


class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: AppConstants.base_url,
      receiveDataWhenStatusError: true,
      followRedirects: false,
      validateStatus: (status) { return status! < 500; },
      // connectTimeout: 60 * 1000 ,
      // 60 seconds
      // receiveTimeout: 60 * 1000 ,
    ));
  }

  static Future<Response> getData({
    required url,
    Map<String, dynamic>? qurey,
    String? token,
  }
      /////////////////////
      )async {
    dio.options.headers =
    {
      'Authorization': token ??'test',
      'Authorization': SharedPreferenceGetValue.token.isEmpty? '':"Bearer ${SharedPreferenceGetValue.token}",
       // "country":await SharedPreferenceGetValue.getCountryID(),
       // "api-token":"TESTPOSTMAN",
      'Content-Type': 'application/json',
    };
    print(dio.options.headers.toString());
    return await dio.get(url,queryParameters: qurey);
  }
//////////////////////////

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    // Map<String, dynamic>? query,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async
  {
    dio.options.headers =
    {
      'lang':lang,
      'Authorization': token ??'test',

      'Authorization': SharedPreferenceGetValue.token.isEmpty? '':"Bearer ${SharedPreferenceGetValue.token}",
       // "api-token":"TESTPOSTMAN",
      // "country":await SharedPreferenceGetValue.getCountryID(),
      'Content-Type': 'application/json',
    };

    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
  static Future<Response> postDataFormat({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async
  {
    dio.options.headers =
    {
      'lang':lang,
      'Authorization': token ??'test',
      // 'Authorization': SharedPreferenceGetValue.token.isEmpty? '':"Bearer ${SharedPreferenceGetValue.token}",
      // "country":await SharedPreferenceGetValue.getCountryID(),
      // "api-token":"TESTPOSTMAN",
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
    };

    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async
  {
    dio.options.headers =
    {
      'lang':lang,
      'Authorization': token??'',
      // "country":await SharedPreferenceGetValue.getCountryID(),
      "api-token":"TESTPOSTMAN",
      'Content-Type': 'application/json',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
  static Future<Response> deleteData({
    required String url,
    required Map<String, dynamic> data,
    // Map<String, dynamic>? query,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async
  {
    dio.options.headers =
    {
      'lang':lang,
      'Authorization': "Bearer $token" ,
      // "api-token":"poOLz4qcSBdmbS9X",
      'Content-Type': 'application/json',
    };

    return dio.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
