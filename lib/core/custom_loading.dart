import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final double padding;
  const CustomLoading({super.key, this.padding = 0});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(color: ColorManager.secondColor, strokeWidth: 5),
        ),
      ),
    );
  }
}
class CustomError extends StatelessWidget {
  final double padding;
  final String errorMessage;
  const CustomError({super.key, this.padding = 0, this.errorMessage=""});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Center(
        child: SizedBox(
          // width: 30,
          // height: 30,
          child: Text(errorMessage,style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s18),),
        ),
      ),
    );
  }
}
class CustomEmpty extends StatelessWidget {
  final double padding;
  final String empty;
  const CustomEmpty({super.key, this.padding = 0, this.empty=""});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Center(
        child: SizedBox(
          // width: 30,
          // height: 30,
          child: Text(empty,style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s18),),
        ),
      ),
    );
  }
}