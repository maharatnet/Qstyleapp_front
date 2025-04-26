import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
  }) : super(key: key);

  // final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.white,
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset("assets/images/ps4_console_white_2.png"),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 "كوتشي",
                  style:  getBoldStyle(color: Colors.black, fontSize: 16),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    text: "\$200",
                    style: getBoldStyle(
                        color: kPrimaryColor),
                    children: [
                      TextSpan(
                          text: " x 10",
                          style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16)),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10,),
          Container(
            width: 8,
            height: 100,
            decoration: BoxDecoration(
              color: ColorManager.error,
              borderRadius: BorderRadius.circular(12)
            ),
          ),


        ],
      ),
    );
  }
}

