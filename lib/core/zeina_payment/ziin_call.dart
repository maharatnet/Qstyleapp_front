import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/core/zeina_payment/ziina_payment_service.dart';
import 'package:maharat_ecommerce/core/zeina_payment/ziina_webview_screen.dart';

void startZiinaPayment(BuildContext context,double amount) async {

  final url = await createZiinaPaymentLink(
  // final url = await createPaymentIntent(
    amount: amount, // 15.00 AED
    description: 'شراء منتج رقم 1001',
    customerName: 'Mohammed HBK',
    customerEmail: 'test@example.com',
    customerPhone: '971504773247',
  );

  if (url != null) {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ZiinaWebViewScreen(paymentUrl: url),
      ),
    );

    if (result == true) {
      // ✅ الدفع تم بنجاح
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ تم الدفع بنجاح')),
      );
    } else {
      // ❌ تم الإلغاء أو فشل الدفع
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ لم يتم الدفع')),
      );
    }
  } else {
    // خطأ في إنشاء رابط الدفع
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('⚠️ فشل في إنشاء رابط الدفع')),
    );
  }
}