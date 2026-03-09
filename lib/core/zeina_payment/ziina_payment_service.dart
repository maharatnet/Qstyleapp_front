import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/core/zeina_payment/ziina_webview_screen.dart';
class ZiinaConfig {
  static const String baseUrl = 'https://api-v2.ziina.com/api'; // ✅ الـ URL الصحيح
  static const String secretKey = 'Bearer VQEZ2+ulSPtQAjCaAcFr757sFjH87FfuP1ZMfK808EtK0gBgKG/jxEANunMfn2zS'; // ⚠️ غير هذا بمفتاحك الحقيقي
  static const String defaultCurrency = 'AED';
  static const int defaultExpirySeconds = 3600;
  static const String callbackUrl = 'https://yourapp.com/payment-success';

  static final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {
      'Authorization': secretKey,
      'Content-Type': 'application/json',
    },
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));
}

/// 🔐 إنشاء Payment Link (الطريقة الصحيحة)
Future<String?> createZiinaPaymentLink({
  required double amount, // المبلغ بالدرهم (مش بالفلوس)
  required String description,
  required String customerName,
  required String customerEmail,
  required String customerPhone,
}) async {
  try {
    // ✅ التحقق من الاتصال بالإنترنت أولاً
    print('🔍 التحقق من الاتصال بالإنترنت...');

    // تحويل المبلغ من درهم إلى فلوس (1 درهم = 100 فلس)
    final int amountInFils = (amount * 100).round();

    print('🔄 إنشاء Payment Link...');
    print('المبلغ: $amount AED ($amountInFils فلس)');
    print('🌐 Base URL: ${ZiinaConfig.baseUrl}');
    print('🔑 Authorization: ${ZiinaConfig.secretKey.substring(0, 20)}...');

    final response = await ZiinaConfig.dio.post(
      '/payment_intent', // ✅ الـ endpoint الصحيح
      data: {
        'amount': amountInFils,
        'currency_code': ZiinaConfig.defaultCurrency, // ✅ currency_code بدلاً من currency
        'description': description,
        'customer': {
          'name': customerName,
          'email': customerEmail,
          'phone': customerPhone,
        },
        'callback_url': ZiinaConfig.callbackUrl,
        'expiry': (DateTime.now().millisecondsSinceEpoch + (3600 * 1000)).toString()
      },
    );

    print('📤 Response Status: ${response.statusCode}');
    print('📋 Response Data: ${response.data}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final paymentUrl = response.data['redirect_url'];
      // final paymentUrl = response.data['url'];
      print('✅ تم إنشاء Payment Link بنجاح: $paymentUrl');
      return paymentUrl;
    } else {
      print('❌ خطأ في إنشاء Payment Link: ${response.statusCode}');
      print('📄 تفاصيل الخطأ: ${response.data}');
      return null;
    }
  } on DioException catch (e) {
    print('❌ Dio Exception: ${e.type}');
    print('📄 Error Message: ${e.message}');

    // معالجة أخطاء الاتصال
    if (e.type == DioExceptionType.connectionError) {
      print('🔌 مشكلة في الاتصال بالإنترنت');
      print('💡 الحلول المحتملة:');
      print('   - تأكد من الاتصال بالإنترنت');
      print('   - تأكد من إعدادات الشبكة في Android');
      print('   - جرب شبكة إنترنت أخرى');
    } else if (e.type == DioExceptionType.connectionTimeout) {
      print('⏱️ انتهت مهلة الاتصال');
    } else if (e.type == DioExceptionType.sendTimeout) {
      print('📤 انتهت مهلة الإرسال');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      print('📥 انتهت مهلة الاستقبال');
    } else if (e.type == DioExceptionType.badResponse) {
      print('🔴 Bad Response من السيرفر');
      if (e.response != null) {
        print('🔢 Status Code: ${e.response?.statusCode}');
        print('📋 Response Headers: ${e.response?.headers}');
        print('📄 Response Data: ${e.response?.data}');
        print('🔗 Request URL: ${e.response?.requestOptions.uri}');
        print('📤 Request Data: ${e.response?.requestOptions.data}');
        print('🔑 Request Headers: ${e.response?.requestOptions.headers}');
      }
    }

    if (e.response != null) {
      print('📋 Error Response: ${e.response?.data}');
      print('🔢 Status Code: ${e.response?.statusCode}');
    }
    return null;
  } catch (e) {
    print('❌ خطأ غير متوقع: $e');
    return null;
  }
}

/// 📊 التحقق من حالة الدفع
Future<Map<String, dynamic>?> checkPaymentStatus(String paymentLinkId) async {
  try {
    final response = await ZiinaConfig.dio.get('/payment-links/$paymentLinkId');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      print('❌ خطأ في التحقق من حالة الدفع: ${response.statusCode}');
      return null;
    }
  } on DioException catch (e) {
    print('❌ Dio Exception في التحقق: ${e.message}');
    return null;
  } catch (e) {
    print('❌ خطأ غير متوقع في التحقق: $e');
    return null;
  }
}

/// 💳 Widget لعرض Payment Link
class ZiinaPaymentWidget extends StatefulWidget {
  final double amount;
  final String description;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final Function(bool success) onPaymentComplete;

  const ZiinaPaymentWidget({
    Key? key,
    required this.amount,
    required this.description,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.onPaymentComplete,
  }) : super(key: key);

  @override
  State<ZiinaPaymentWidget> createState() => _ZiinaPaymentWidgetState();
}

class _ZiinaPaymentWidgetState extends State<ZiinaPaymentWidget> {
  bool isLoading = false;
  String? errorMessage;

  Future<void> _startPayment() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final paymentUrl = await createZiinaPaymentLink(
        amount: widget.amount,
        description: widget.description,
        customerName: widget.customerName,
        customerEmail: widget.customerEmail,
        customerPhone: widget.customerPhone,
      );

      if (paymentUrl != null) {
        // فتح الـ WebView
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ZiinaWebViewScreen(paymentUrl: paymentUrl),
          ),
        );

        widget.onPaymentComplete(result == true);
      } else {
        setState(() {
          errorMessage = 'فشل في إنشاء رابط الدفع';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'حدث خطأ: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'الدفع عبر زيينا',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            Text('المبلغ: ${widget.amount} درهم'),
            Text('الوصف: ${widget.description}'),
            Text('العميل: ${widget.customerName}'),

            const SizedBox(height: 16),

            if (errorMessage != null)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red.shade700),
                  textAlign: TextAlign.center,
                ),
              ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: isLoading ? null : _startPayment,
              child: isLoading
                  ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('جاري المعالجة...'),
                ],
              )
                  : const Text('ادفع الآن'),
            ),
          ],
        ),
      ),
    );
  }
}
 /// 000000 ///
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:maharat_ecommerce/core/zeina_payment/ziina_webview_screen.dart';
//
// class ZiinaConfig {
//   static const String baseUrl = 'https://api-v2.ziina.com/api'; // ✅ الـ URL الصحيح
//   static const String secretKey = 'Bearer VQEZ2+ulSPtQAjCaAcFr757sFjH87FfuP1ZMfK808EtK0gBgKG/jxEANunMfn2zS'; // ⚠️ غير هذا بمفتاحك الحقيقي
//   static const String defaultCurrency = 'AED';
//   static const int defaultExpiryMinutes = 60; // 60 دقيقة بدلاً من ثوانٍ
//   static const String callbackUrl = 'https://yourapp.com/payment-success';
//   static const String cancelUrl = 'https://yourapp.com/payment-cancel';
//
//   static final Dio dio = Dio(BaseOptions(
//     baseUrl: baseUrl,
//     headers: {
//       'Authorization': secretKey,
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     },
//     connectTimeout: const Duration(seconds: 30),
//     receiveTimeout: const Duration(seconds: 30),
//   ));
// }
//
// /// 🔐 إنشاء Payment Link (الطريقة المُصححة)
// Future<String?> createZiinaPaymentLink({
//   required double amount, // المبلغ بالدرهم
//   required String description,
//   required String customerName,
//   required String customerEmail,
//   required String customerPhone,
// }) async {
//   try {
//     // ✅ التحقق من الاتصال بالإنترنت أولاً
//     print('🔍 التحقق من الاتصال بالإنترنت...');
//
//     // تحويل المبلغ من درهم إلى فلوس (1 درهم = 100 فلس)
//     final int amountInFils = (amount * 100).round();
//
//     // حساب تاريخ الانتهاء الصحيح
//     final expiryDateTime = DateTime.now().add(Duration(minutes: ZiinaConfig.defaultExpiryMinutes));
//
//     print('🔄 إنشاء Payment Link...');
//     print('المبلغ: $amount AED ($amountInFils فلس)');
//     print('🌐 Base URL: ${ZiinaConfig.baseUrl}');
//     print('🔑 Authorization: ${ZiinaConfig.secretKey.substring(0, 20)}...');
//     print('⏰ تاريخ الانتهاء: $expiryDateTime');
//
//     // ✅ الـ payload الصحيح لـ Payment Link
//     final payload = {
//       'amount': amountInFils,
//       'currency': ZiinaConfig.defaultCurrency, // ✅ currency بدلاً من currency_code
//       'description': description,
//       'external_id': 'payment_${DateTime.now().millisecondsSinceEpoch}', // معرف فريد
//       'customer': {
//         'name': customerName,
//         'email': customerEmail,
//         'phone': customerPhone,
//       },
//       'success_url': ZiinaConfig.callbackUrl,
//       'cancel_url': ZiinaConfig.cancelUrl,
//       'expires_at': expiryDateTime.toIso8601String(), // ✅ تاريخ الانتهاء بتنسيق ISO
//     };
//
//     print('📤 إرسال الطلب إلى: ${ZiinaConfig.baseUrl}/payment-links');
//     print('📋 البيانات المُرسلة: $payload');
//
//     final response = await ZiinaConfig.dio.post(
//       '/payment-links', // ✅ الـ endpoint الصحيح لـ Payment Links
//       data: payload,
//     );
//
//     print('📤 Response Status: ${response.statusCode}');
//     print('📋 Response Data: ${response.data}');
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final paymentUrl = response.data['url'];
//       print('✅ تم إنشاء Payment Link بنجاح: $paymentUrl');
//       return paymentUrl;
//     } else {
//       print('❌ خطأ في إنشاء Payment Link: ${response.statusCode}');
//       print('📄 تفاصيل الخطأ: ${response.data}');
//       return null;
//     }
//   } on DioException catch (e) {
//     print('❌ Dio Exception: ${e.type}');
//     print('📄 Error Message: ${e.message}');
//
//     // معالجة أخطاء الاتصال
//     if (e.type == DioExceptionType.connectionError) {
//       print('🔌 مشكلة في الاتصال بالإنترنت');
//       print('💡 الحلول المحتملة:');
//       print('   - تأكد من الاتصال بالإنترنت');
//       print('   - تأكد من إعدادات الشبكة في Android');
//       print('   - جرب شبكة إنترنت أخرى');
//     } else if (e.type == DioExceptionType.connectionTimeout) {
//       print('⏱️ انتهت مهلة الاتصال');
//     } else if (e.type == DioExceptionType.sendTimeout) {
//       print('📤 انتهت مهلة الإرسال');
//     } else if (e.type == DioExceptionType.receiveTimeout) {
//       print('📥 انتهت مهلة الاستقبال');
//     } else if (e.type == DioExceptionType.badResponse) {
//       print('🔴 Bad Response من السيرفر');
//       if (e.response != null) {
//         print('🔢 Status Code: ${e.response?.statusCode}');
//         print('📋 Response Headers: ${e.response?.headers}');
//         print('📄 Response Data: ${e.response?.data}');
//         print('🔗 Request URL: ${e.response?.requestOptions.uri}');
//         print('📤 Request Data: ${e.response?.requestOptions.data}');
//         print('🔑 Request Headers: ${e.response?.requestOptions.headers}');
//
//         // معالجة أخطاء زيينا المحددة
//         if (e.response?.data != null && e.response?.data is Map) {
//           final errorData = e.response?.data as Map<String, dynamic>;
//           if (errorData.containsKey('code')) {
//             switch (errorData['code']) {
//               case 'INVALID_AMOUNT':
//                 print('💰 المبلغ غير صحيح');
//                 break;
//               case 'INVALID_CURRENCY':
//                 print('💱 العملة غير مدعومة');
//                 break;
//               case 'INVALID_CUSTOMER':
//                 print('👤 بيانات العميل غير صحيحة');
//                 break;
//               case 'UNAUTHORIZED':
//                 print('🔐 مفتاح الـ API غير صحيح');
//                 break;
//               case 'RECIPIENT_NOT_ACTIVE_WALLET':
//                 print('⚠️ خطأ: يبدو أن الـ endpoint غير صحيح - هذا خطأ خاص بالتحويلات وليس Payment Links');
//                 break;
//               default:
//                 print('❌ خطأ من زيينا: ${errorData['message']}');
//             }
//           }
//         }
//       }
//     }
//
//     if (e.response != null) {
//       print('📋 Error Response: ${e.response?.data}');
//       print('🔢 Status Code: ${e.response?.statusCode}');
//     }
//     return null;
//   } catch (e) {
//     print('❌ خطأ غير متوقع: $e');
//     return null;
//   }
// }
//
// /// 📊 التحقق من حالة الدفع
// Future<Map<String, dynamic>?> checkPaymentStatus(String paymentLinkId) async {
//   try {
//     final response = await ZiinaConfig.dio.get('/payment-links/$paymentLinkId');
//
//     if (response.statusCode == 200) {
//       return response.data;
//     } else {
//       print('❌ خطأ في التحقق من حالة الدفع: ${response.statusCode}');
//       return null;
//     }
//   } on DioException catch (e) {
//     print('❌ Dio Exception في التحقق: ${e.message}');
//     return null;
//   } catch (e) {
//     print('❌ خطأ غير متوقع في التحقق: $e');
//     return null;
//   }
// }
//
// /// 💳 Widget لعرض Payment Link
// class ZiinaPaymentWidget extends StatefulWidget {
//   final double amount;
//   final String description;
//   final String customerName;
//   final String customerEmail;
//   final String customerPhone;
//   final Function(bool success) onPaymentComplete;
//
//   const ZiinaPaymentWidget({
//     Key? key,
//     required this.amount,
//     required this.description,
//     required this.customerName,
//     required this.customerEmail,
//     required this.customerPhone,
//     required this.onPaymentComplete,
//   }) : super(key: key);
//
//   @override
//   State<ZiinaPaymentWidget> createState() => _ZiinaPaymentWidgetState();
// }
//
// class _ZiinaPaymentWidgetState extends State<ZiinaPaymentWidget> {
//   bool isLoading = false;
//   String? errorMessage;
//
//   Future<void> _startPayment() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });
//
//     try {
//       final paymentUrl = await createZiinaPaymentLink(
//         amount: widget.amount,
//         description: widget.description,
//         customerName: widget.customerName,
//         customerEmail: widget.customerEmail,
//         customerPhone: widget.customerPhone,
//       );
//
//       if (paymentUrl != null) {
//         // فتح الـ WebView
//         final result = await Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ZiinaWebViewScreen(paymentUrl: paymentUrl),
//           ),
//         );
//
//         widget.onPaymentComplete(result == true);
//       } else {
//         setState(() {
//           errorMessage = 'فشل في إنشاء رابط الدفع';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'حدث خطأ: $e';
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.payment, color: Colors.blue, size: 28),
//                 const SizedBox(width: 8),
//                 Text(
//                   'الدفع عبر زيينا',
//                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             // معلومات الدفع
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey.shade200),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.monetization_on, size: 16, color: Colors.green),
//                       const SizedBox(width: 4),
//                       Text('المبلغ: ${widget.amount} درهم إماراتي'),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(Icons.description, size: 16, color: Colors.grey),
//                       const SizedBox(width: 4),
//                       Expanded(child: Text('الوصف: ${widget.description}')),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(Icons.person, size: 16, color: Colors.grey),
//                       const SizedBox(width: 4),
//                       Text('العميل: ${widget.customerName}'),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             if (errorMessage != null)
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.red.shade100,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.red.shade200),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.error, color: Colors.red.shade700, size: 20),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         errorMessage!,
//                         style: TextStyle(
//                           color: Colors.red.shade700,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//             const SizedBox(height: 16),
//
//             ElevatedButton.icon(
//               onPressed: isLoading ? null : _startPayment,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               icon: isLoading
//                   ? const SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                 ),
//               )
//                   : const Icon(Icons.payment),
//               label: Text(
//                 isLoading ? 'جاري المعالجة...' : 'ادفع الآن',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
