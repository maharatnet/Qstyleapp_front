import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:maharat_ecommerce/component/app_constants.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/core/zeina_payment/ziina_payment_service.dart';

// class ZiinaWebViewScreen extends StatefulWidget {
//   final String paymentUrl;
//
//   const ZiinaWebViewScreen({required this.paymentUrl, super.key});
//
//   @override
//   State<ZiinaWebViewScreen> createState() => _ZiinaWebViewScreenState();
// }
//
// class _ZiinaWebViewScreenState extends State<ZiinaWebViewScreen> {
//   late InAppWebViewController webViewController;
//   bool paymentSuccess = false;
//   bool loading = true;
//
//   final String callbackUrl = 'https://yourapp.com/payment-success'; // نفس اللي في API
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('الدفع'),
//       ),
//       body: Stack(
//         children: [
//           InAppWebView(
//             initialUrlRequest: URLRequest(url: WebUri(widget.paymentUrl)),
//             // initialUrlRequest: URLRequest(url: Uri.parse(widget.paymentUrl)),
//             onWebViewCreated: (controller) {
//               webViewController = controller;
//             },
//             onLoadStop: (controller, url) async {
//               if (url.toString().startsWith(callbackUrl)) {
//                 setState(() {
//                   paymentSuccess = true;
//                 });
//                 Navigator.pop(context, true); // يرجع ويقول تم الدفع
//               }
//             },
//             onLoadError: (_, __, ___, ____) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('حدث خطأ في تحميل صفحة الدفع')),
//               );
//               Navigator.pop(context, false);
//             },
//             onProgressChanged: (_, progress) {
//               if (progress == 100) {
//                 setState(() => loading = false);
//               }
//             },
//           ),
//           if (loading)
//             const Center(child: CircularProgressIndicator()),
//         ],
//       ),
//     );
//   }
// }

class ZiinaWebViewScreen extends StatefulWidget {
  final String paymentUrl;

  const ZiinaWebViewScreen({required this.paymentUrl, super.key});

  @override
  State<ZiinaWebViewScreen> createState() => _ZiinaWebViewScreenState();
}

class _ZiinaWebViewScreenState extends State<ZiinaWebViewScreen> {
  late InAppWebViewController webViewController;
  bool loading = true;
  String? currentUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(TextApp.pay.tr()),
        backgroundColor: ColorManager.secondColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              webViewController.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.paymentUrl)),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                loading = true;
                currentUrl = url.toString();
              });
            },
            onLoadStop: (controller, url) async {
              setState(() {
                loading = false;
                currentUrl = url.toString();
              });

              print('🔗 Current URL: $currentUrl');

              // التحقق من callback URL
              // هنرجع نضيفها تاني
              // if (currentUrl!.startsWith(ZiinaConfig.callbackUrl)) {
              //   print('✅ تم الدفع بنجاح!');
              //   Navigator.pop(context, true);
              // }

              // التحقق من URLs أخرى تدل على النجاح
              if (currentUrl!.contains('success') ||
                  currentUrl!.contains('completed') ||
                  currentUrl!.contains('paid')) {
                print('✅ تم الدفع بنجاح (من URL)!');
                Navigator.pop(context, true);
              }
            },
            onLoadError: (controller, url, code, message) {
              print('❌ خطأ في تحميل الصفحة: $message');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('حدث خطأ في تحميل صفحة الدفع: $message'),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.pop(context, false);
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                setState(() => loading = false);
              }
            },
          ),
          if (loading)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('جاري تحميل صفحة الدفع...'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}