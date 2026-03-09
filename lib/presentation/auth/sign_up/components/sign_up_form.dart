import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/custom_button.dart';
import 'package:maharat_ecommerce/component/custom_suffix_icons.dart';
import 'package:maharat_ecommerce/component/form_error.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/auth/sign_up/register_cubit.dart';



class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){},
    builder: (context,state){
          final cubit = RegisterCubit.get(context);
          return Form(
            key: cubit.formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.name,
                  onSaved: (newValue) => cubit.name = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      cubit.removeError(error: kNamelNullError);
                    }
                    // else if (emailValidatorRegExp.hasMatch(value)) {
                    //   removeError(error: kInvalidEmailError);
                    // }
                    return;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      cubit.addErrorTwo(error: kNamelNullError);
                      return "";
                    }
                    // else if (!emailValidatorRegExp.hasMatch(value)) {
                    //   addError(error: kInvalidEmailError);
                    //   return "";
                    // }
                    return null;
                  },
                  decoration:  InputDecoration(
                    labelText: tr(TextApp.name),
                    hintText: tr(TextApp.enterYourName),
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
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
                IntlPhoneField(
                  initialCountryCode: 'AE', // 🇦🇪 الإمارات كافتراضي
                  decoration: InputDecoration(
                    labelText: tr(TextApp.phone),
                    hintText: tr(TextApp.enterYourPhone),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ColorManager.lightPrimary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ColorManager.lightPrimary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ColorManager.lightPrimary),
                    ),
                  ),
                  onChanged: (phone) {
                    cubit.phone = phone.completeNumber;
                    if (phone.number.isNotEmpty) {
                      cubit.removeError(error: kPhoneNullError);
                    }
                  },
                  onSaved: (phone) {
                    cubit.phone = phone?.completeNumber;
                  },
                  validator: (phone) {
                    if (phone == null || phone.number.isEmpty) {
                      cubit.addErrorTwo(error: kPhoneNullError);
                      return "";
                    }
                    return null;
                  },
                ),

                // TextFormField(
                //   keyboardType: TextInputType.phone,
                //   onSaved: (newValue) => cubit.phone = newValue,
                //   onChanged: (value) {
                //     if (value.isNotEmpty) {
                //       cubit.removeError(error: kPhoneNullError);
                //     }
                //     // else if (emailValidatorRegExp.hasMatch(value)) {
                //     //   removeError(error: kInvalidEmailError);
                //     // }
                //     return;
                //   },
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       cubit.addErrorTwo(error: kPhoneNullError);
                //       return "";
                //     }
                //     // else if (!emailValidatorRegExp.hasMatch(value)) {
                //     //   addError(error: kInvalidEmailError);
                //     //   return "";
                //     // }
                //     return null;
                //   },
                //   decoration:  InputDecoration(
                //     labelText: tr(TextApp.phone),
                //     hintText: tr(TextApp.enterYourPhone),
                //     // If  you are using latest version of flutter then lable text and hint text shown like this
                //     // if you r using flutter less then 1.20.* then maybe this is not working properly
                //     floatingLabelBehavior: FloatingLabelBehavior.always,
                //     suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
                //     isDense: true, // لتقليل الحجم العام
                //     contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                //     filled: true,
                //     fillColor: Colors.grey.shade100,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: BorderSide(color:  ColorManager.lightPrimary),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: BorderSide(color:  ColorManager.lightPrimary),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: BorderSide(color:  ColorManager.lightPrimary),
                //     ),
                //
                //   ),
                // ),
                const SizedBox(height: 20),
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
                      cubit.addErrorTwo(error: kEmailNullError);
                      return "";
                    } else if (!emailValidatorRegExp.hasMatch(value)) {
                      cubit.addErrorTwo(error: kInvalidEmailError);
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
                      cubit.addErrorTwo(error: kPassNullError);
                      return "";
                    } else if (value.length < 8) {
                      cubit.addErrorTwo(error: kShortPassError);
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
                      cubit.addErrorTwo(error: kPassNullError);
                      return "";
                    } else if ((cubit.password != value)) {
                      cubit.addErrorTwo(error: kMatchPassError);
                      return "";
                    }
                    return null;
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
                SizedBox(height: 20),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: cubit.selectedGender,
                      onChanged: (value) {
                        cubit.selectedGender = value;
                        cubit.refreshData();
                      },
                    ),
                    Text(tr(TextApp.male)),
                    SizedBox(
                      width: 20,
                    ),
                    Radio<String>(
                      value: 'Female',
                      groupValue: cubit.selectedGender,
                      onChanged: (value) {
                        cubit.selectedGender = value;
                        cubit.refreshData();
                      },
                    ),
                    Text(tr(TextApp.female)),
                  ],
                ),
                const SizedBox(height: 20),
                FormError(errors: cubit.errors),
                const SizedBox(height: 20),
                CustomButton(
                  backgroundColor: ColorManager.secondColor,
                  buttonText: tr(TextApp.signUp),
                  isBuy: state is LoadingRegisterGetStates,
                  onTap: (){
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.formKey.currentState!.save();
                      cubit.registerApi(context, {
                        "name":cubit.name,
                        "email":cubit.email,
                        "mobile":cubit.phone,
                        "password":cubit.password,
                        "gender":cubit.selectedGender,
                      });
                      // if all are valid then go to success screen
                      // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                    }
                  },
                  textColor: Colors.white,
                ),

              ],
            ),
          );
    },
    );
  }
}
