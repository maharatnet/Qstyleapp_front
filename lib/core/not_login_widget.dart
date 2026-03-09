
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/custom_button.dart';
import 'package:maharat_ecommerce/component/dimensions.dart';
import 'package:maharat_ecommerce/component/image_assets.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/auth/sign_in/sign_in_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';


class NotLoggedInWidget extends StatelessWidget {
  const NotLoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child:CircleAvatar(
          radius: 30,
          backgroundColor: ColorManager.secondColor.withOpacity(0.1),
          child: Icon(
            Icons.person_outline,
            size: 35,
            color: ColorManager.secondColor,
          ),
        )
        // SizedBox(width: 60,child: Image.asset(ImageAssets.loginIcon))
        ,),
      Text(tr(TextApp.pleaseLogIn), style: getBoldStyle(
          color: ColorManager.black,
          fontSize: Dimensions.fontSizeLarge),),

      Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
        child: Text(tr(TextApp.pleaseSignInFirst)),),

      Center(child: SizedBox(width: 180,child: CustomButton(buttonText: tr(TextApp.login),
          backgroundColor: ColorManager.black,
           textColor: ColorManager.white,
          onTap: () {
        navigateTo(context, SignInScreen());
          })),
      ),
      InkWell(onTap: ()
    {
      navigateAndFinish(context, BottomNavigationScreen());
    },
        child: Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
          child: Text(tr(TextApp.backToHomePage),
            style: TextStyle(fontSize: Dimensions.fontSizeLarge,
                color: ColorManager.secondColor,
                decoration: TextDecoration.underline),),
        ),
      ),
    ],
    );
  }
}
