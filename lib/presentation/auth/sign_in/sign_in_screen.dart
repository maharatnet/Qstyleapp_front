import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/presentation/auth/sign_up/sign_up_screen.dart';
import 'components/sign_form.dart';

class SignInScreen extends StatelessWidget {

  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title:  Text("Sign In",style: getBoldStyle(color: c),),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   Text(
                    "QStyle",
                    textAlign: TextAlign.center,
                    style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s20),
                  ),
                  Text(
                    "Sign in with your email and password ",
                    textAlign: TextAlign.center,
                    style: getBoldStyle(color: ColorManager.primary,
                    fontSize: FontSize.s16),
                  ),
                  const SizedBox(height: 16),
                  const SignForm(),
                  const SizedBox(height: 16),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SocalCard(
                  //       icon: "assets/icons/google-icon.svg",
                  //       press: () {},
                  //     ),
                  //     SocalCard(
                  //       icon: "assets/icons/facebook-2.svg",
                  //       press: () {},
                  //     ),
                  //     SocalCard(
                  //       icon: "assets/icons/twitter.svg",
                  //       press: () {},
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  const NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          "Don’t have an account? ",
          style: getBoldStyle(fontSize: 15, color: ColorManager.black),
        ),
        GestureDetector(
          onTap: () {
            navigateTo(context, SignUpScreen());
          },
          child: Text(
            "Sign Up",
            style: getBoldStyle(fontSize: 16, color: ColorManager.primary),
          ),
        ),
      ],
    );
  }
}