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
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/auth/forget_password/cubit/forget_password_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
class CreateNewPasswordScreen extends StatelessWidget {
 final String otp;
 final String email;
  const CreateNewPasswordScreen({Key? key,required this.email, required this.otp}) : super(key: key);

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
                child: Form(
                  key: cubit.formKey,
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
                            tr(TextApp.enterEmailToSetNewPassword ),
                            textAlign: TextAlign.center,
                            style: getBoldStyle(color: ColorManager.primary,
                                fontSize: FontSize.s16),
                          ),
                          const SizedBox(height: 25),
                          const SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            onSaved: (newValue) => cubit.password = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                cubit.removeError(error: kPassNullError);
                              } else if (value.length >= 8) {
                                cubit.removeError(error: kShortPassError);
                              }
                              cubit.password = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                cubit.addErrorTWO(error: kPassNullError);
                                return "";
                              } else if (value.length < 8) {
                                cubit.addErrorTWO(error: kShortPassError);
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
                              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
                          TextFormField(
                            obscureText: true,
                            onSaved: (newValue) => cubit.conform_password = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                cubit.removeError(error: kPassNullError);
                              } else if (value.isNotEmpty && cubit.password == cubit.conform_password) {
                                cubit.removeError(error: kMatchPassError);
                              }
                              cubit.conform_password = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                cubit.addErrorTWO(error: kPassNullError);
                                return "";
                              } else if ((cubit.password != value)) {
                                cubit.addErrorTWO(error: kMatchPassError);
                                return "";
                              }
                              // return null;
                            },
                            decoration:  InputDecoration(
                              labelText: tr(TextApp.confirmPassword),
                              hintText: tr(TextApp.reEnterYourPassword),
                              // If  you are using latest version of flutter then lable text and hint text shown like this
                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
                          FormError(errors: cubit.errors),
                          const SizedBox(height: 20),
                          CustomButton(
                            backgroundColor: ColorManager.secondColor,
                            buttonText: tr(TextApp.submit),
                            onTap: (){
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.formKey.currentState!.save();
                        cubit.resetPassword(context,{
                          "email":email,
                          "otp_code":otp,
                          "new_password":cubit.password,
                          "password_confirmation":cubit.conform_password
                        } );
                      }
                              // navigateAndFinish(context, BottomNavigationScreen());
                              //
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
            ),
          );

        },
    ),
    );
  }
}
