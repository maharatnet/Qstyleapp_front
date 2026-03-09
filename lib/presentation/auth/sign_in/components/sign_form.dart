import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/custom_button.dart';
import 'package:maharat_ecommerce/component/custom_suffix_icons.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/form_error.dart';
import 'package:maharat_ecommerce/component/keyboard_util.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/auth/forget_password/enter_email_forget_password.dart';
import 'package:maharat_ecommerce/presentation/auth/sign_in/cubit/login_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'package:maharat_ecommerce/start_up.dart';


class SignForm extends StatelessWidget {
  const SignForm({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<LoginCubit,LoginStates>(
       listener: (context,state){},
     builder: (context,state){
         final cubit = LoginCubit.get(context);
         return Form(
           key: cubit.formKey,
           child: Column(
             children: [
               TextFormField(
                 keyboardType: TextInputType.emailAddress,
                 onSaved: (newValue) => cubit.email = newValue,
                 onChanged: (value) {
                   if (value.isNotEmpty) {
                     cubit.removeError(error: kEmailNullError);
                   } else if (emailValidatorRegExp.hasMatch(value)) {
                     cubit.removeError(error: kInvalidEmailError);
                   }
                   return;
                 },
                 validator: (value) {
                   if (value!.isEmpty) {
                     cubit.addTwoError(error: kEmailNullError);
                     return "";
                   } else if (!emailValidatorRegExp.hasMatch(value)) {
                     cubit.addTwoError(error: kInvalidEmailError);
                     return "";
                   }
                   return null;
                 },

                 decoration:  InputDecoration(
                   labelText: tr(TextApp.email),
                   hintText: tr(TextApp.enterYourEmail),

                   // If  you are using latest version of flutter then lable text and hint text shown like this
                   // if you r using flutter less then 1.20.* then maybe this is not working properly
                   floatingLabelBehavior: FloatingLabelBehavior.always,
                   suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                   isDense: true, // لتقليل الحجم العام
                   contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                   filled: true,
                   suffixStyle: getBoldStyle(color: Colors.grey),
                   fillColor: Colors.grey.shade100,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide(color: ColorManager.lightPrimary),
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide(color:  ColorManager.lightPrimary),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide(color:  ColorManager.lightPrimary),
                   ),
                 ),


               ),
               const SizedBox(height: 20),
               TextFormField(
                 obscureText: cubit.obscureText,
                 onSaved: (newValue) => cubit.password = newValue,
                 onChanged: (value) {
                   if (value.isNotEmpty) {
                     cubit.removeError(error: kPassNullError);
                   } else if (value.length >= 8) {
                     cubit.removeError(error: kShortPassError);
                   }
                   return;
                 },
                 validator: (value) {
                   if (value!.isEmpty) {
                     cubit.addTwoError(error: kPassNullError);
                     return "";
                   } else if (value.length < 8) {
                     cubit.addTwoError(error: kShortPassError);
                     return "";
                   }
                   return null;
                 },
                 decoration:  InputDecoration(
                   labelText: tr(TextApp.password),
                   hintText: tr(TextApp.enterYourPassword),
                   // If  you are using latest version of flutter then lable text and hint text shown like this
                   // if you r using flutter less then 1.20.* then maybe this is not working properly
                   floatingLabelBehavior: FloatingLabelBehavior.always,
                   suffixIcon: GestureDetector(
                       onTap: (){
                         cubit.changeObscureText();
                       },
                       child: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg")),
                   isDense: true, // لتقليل الحجم العام
                   contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                   filled: true,

                   fillColor: Colors.grey.shade100,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide(color:  ColorManager.lightPrimary),
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide(color:  ColorManager.lightPrimary),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide(color:  ColorManager.lightPrimary),
                   ),

                 ),
               ),
               const SizedBox(height: 20),
               Row(
                 children: [
                   // Checkbox(
                   //   value: cubit.remember,
                   //   activeColor: kPrimaryColor,
                   //   onChanged: (value) {
                   //     // setState(() {
                   //       cubit.remember = value;
                   //       cubit.refreshData();
                   //     // });
                   //   },
                   // ),
                   Text(""),
                   // Text(tr(TextApp.rememberMe),style:getBoldStyle(color: Colors.black,fontSize: FontSize.s12) ,),
                   const Spacer(),
                   GestureDetector(
                     onTap: () {
                       navigateTo(context, EnterEmailForgetPassword());
                       // Navigator.pushNamed(context, ForgotPasswordScreen.routeName)
                     },
                     child:  Text(
                       tr(TextApp.forgotPassword),
                       style: getRegularUnderLineStyle(
                         fontSize: FontSize.s14,
                         color: ColorManager.black,
                         // decoration: TextDecoration.underline
                       ),
                     ),
                   )
                 ],
               ),
               FormError(errors: cubit.errors),
               const SizedBox(height: 20),
               CustomButton(
                 backgroundColor: ColorManager.secondColor,
                 buttonText: tr(TextApp.login),
                   isBuy: state is LoadingLoginGetStates,
                 onTap: (){
                   if (cubit.formKey.currentState!.validate()) {
                     cubit.formKey.currentState!.save();
                     // if all are valid then go to success screen
                     KeyboardUtil.hideKeyboard(context);
                   cubit.loginApi(context,{
                     "email":cubit.email??"",
                     "password":cubit.password??"",
                     "fcm_token":firebaseToken,
                   } );
                     // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                   }
                   // navigateAndFinish(context, SignInScreen());
                 },
                 textColor: Colors.white,
               ),
               // ElevatedButton(
               //   onPressed: () {
               //     if (_formKey.currentState!.validate()) {
               //       _formKey.currentState!.save();
               //       // if all are valid then go to success screen
               //       KeyboardUtil.hideKeyboard(context);
               //       // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
               //     }
               //   },
               //   child: const Text("Continue"),
               // ),
             ],
           ),
         );

     },

   );
  }
}
