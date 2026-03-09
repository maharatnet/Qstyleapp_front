import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/auth/sign_in/cubit/login_cubit.dart';
import 'package:maharat_ecommerce/presentation/auth/sign_up/sign_up_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'components/sign_form.dart';

class SignInScreen extends StatelessWidget {

  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
   return BlocProvider(create: (_)=>LoginCubit(),
   child: BlocConsumer<LoginCubit,LoginStates>(
       listener: (context,state){},
       builder: (context,state){
         final cubit = LoginCubit.get(context);
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
                       // const Text(
                       //   "Welcome Back",
                       //   style: TextStyle(
                       //     color: Colors.black,
                       //     fontSize: 24,
                       //     fontWeight: FontWeight.bold,
                       //   ),
                       // ),
                       Text(
                         tr(TextApp.appName),
                         textAlign: TextAlign.center,
                         style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s20),
                       ),
                       // Text(
                       //   "Sign in with your email and password ",
                       //   textAlign: TextAlign.center,
                       //   style: getBoldStyle(color: ColorManager.primary,
                       //       fontSize: FontSize.s16),
                       // ),
                       const SizedBox(height: 16),
                       const SizedBox(height: 16),
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
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           GestureDetector(
                             onTap: (){
                               navigateTo(context, BottomNavigationScreen());
                             },
                             child: Text(
                               tr(TextApp.guest),
                               style: getBoldStyle(fontSize: 18, color: ColorManager.primary),
                             ),
                           ),
                         ],),
                       const SizedBox(height: 20),
                       const NoAccountText(),
                     ],
                   ),
                 ),
               ),
             ),
           ),
         );
       },
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
          tr(TextApp.dontHaveAnAccount),
          style: getBoldStyle(fontSize: 15, color: ColorManager.black),
        ),
        GestureDetector(
          onTap: () {
            navigateTo(context, SignUpScreen());
          },
          child: Text(
            tr(TextApp.signUp),
            style: getBoldStyle(fontSize: 16, color: ColorManager.primary),
          ),
        ),
      ],
    );
  }
}