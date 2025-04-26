import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';



class on_boarding_content_widget extends StatefulWidget {
  const on_boarding_content_widget({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  State<on_boarding_content_widget> createState() => _on_boarding_content_widgetState();
}

class _on_boarding_content_widgetState extends State<on_boarding_content_widget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
         Text(
           appName,
          style: getBoldStyle(
            fontSize: 32,
            color: ColorManager.secondColor,
            // fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.text!,
          textAlign: TextAlign.center,
          style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s16),
        ),
        const Spacer(flex: 2),
        Image.asset(
          widget.image!,
          height: 265,
          width: 235,
        ),
      ],
    );
  }
}
