import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة سلة التسوق (يمكنك تغييرها إلى صورة إذا أردت)
            Icon(
              Icons.shopping_cart_outlined,
              size: 100,
              color: Colors.black87,
            ),

            const SizedBox(height: 20),

            Text(
              tr("shopping_cart_is_empty"),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Text(
              tr("no_products_in_your_cart"),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                 navigateAndFinish(context, BottomNavigationScreen(startIndex: 0,));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child:  Text(
                  tr("continue_shopping"),
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
