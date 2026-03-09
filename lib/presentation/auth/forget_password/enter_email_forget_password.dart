import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/custom_button.dart';
import 'package:maharat_ecommerce/component/custom_suffix_icons.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/auth/forget_password/create_new_password_screen.dart';
import 'package:maharat_ecommerce/presentation/auth/forget_password/cubit/forget_password_cubit.dart';
import 'package:maharat_ecommerce/presentation/auth/forget_password/verify_otp_screen.dart';
class EnterEmailForgetPassword extends StatelessWidget {
  const EnterEmailForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit,ForgetPasswordStates>(
          listener: (context,state){},
          builder: (context,state){
            final cubit = ForgetPasswordCubit.get(context);
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
                            "",  // "Welcome Back",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            tr(TextApp.appName),
                            textAlign: TextAlign.center,
                            style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s20),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            tr(TextApp.enterEmailToSetNewPassword),
                            // tr(TextApp.enterEmailToEnterNewPassword),
                            textAlign: TextAlign.center,
                            style: getBoldStyle(color: ColorManager.primary,
                                fontSize: FontSize.s16),
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (newValue) => cubit.email = newValue!,
                            onChanged: (value) {
                              cubit.email =value;
                              // if (value.isNotEmpty) {
                              //   removeError(error: kEmailNullError);
                              // } else if (emailValidatorRegExp.hasMatch(value)) {
                              //   removeError(error: kInvalidEmailError);
                              // }
                              // return;
                            },
                            validator: (value) {
                              // if (value!.isEmpty) {
                              //   addError(error: kEmailNullError);
                              //   return "";
                              // } else if (!emailValidatorRegExp.hasMatch(value)) {
                              //   addError(error: kInvalidEmailError);
                              //   return "";
                              // }
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
                          // const SizedBox(height: 20),
                          const SizedBox(height: 25),
                          const SizedBox(height: 20),
                          CustomButton(
                            backgroundColor: ColorManager.secondColor,
                            buttonText: tr(TextApp.submit),
                            isBuy: state is LoadingAccountStates,
                            onTap: (){
                              if(cubit.email.isNotEmpty){
                              // cubit.forgetPassword(context, {
                              //   "email":cubit.email
                              // });
                                navigateTo(context, VerfiyOtpScreen(email: cubit.email,));

                              }
                            },
                            textColor: Colors.white,
                          ),

                          const SizedBox(height: 20),
                          // const NoAccountText(),
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
