import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/custom_button.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/auth/verfiy_account/verify_account_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class VerfiyOtpScreen extends StatelessWidget {
  final String email;
  const VerfiyOtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size  = MediaQuery.sizeOf(context);
    return BlocProvider(create: (_)=>VerifyAccountCubit()..forgetPassword(context, email),
      child: BlocConsumer<VerifyAccountCubit,VerifyAccountStates>(
        listener: (context,state){},
        builder: (context,state){
          final cubit = VerifyAccountCubit.get(context);
          return  Scaffold(
            body: SingleChildScrollView(
              child: Container(
                color: ColorManager.white,
                height: size.height,
                width: size.width,
                child: Column(children: [
                  SizedBox(
                    height: 60,
                  ),

                  SizedBox(height: 20,),
                  Row(

                    children: [
                      Spacer(),
                      SizedBox(width: 12,),
                      SizedBox(width: 30,),
                      Text(TextApp.verification_code.tr(),style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s20),),
                      SizedBox(width: 12,),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          child: Center(child: Icon(Icons.arrow_forward_ios),),
                        ),
                      ),
                      SizedBox(width: 12,)
                    ],
                  ),
                  SizedBox(height: 40,),

                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
                    child: Text(TextApp.verification_code_sent_5_digits.tr(),
                      textAlign:TextAlign.center,
                      style: getMediumStyle(color: ColorManager.grey,fontSize: FontSize.s13),),
                  ),
                  // ),


                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*.10,vertical: 12),
                    child: PinCodeTextField(
                      controller:
                      cubit.textEditingCodeController,
                      length: 5,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      enablePinAutofill: true,
                      hintCharacter: '- - -',
                      hintStyle: TextStyle(
                          fontSize: 11, color: const Color(0xffD5D6DD)),
                      showCursor: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      pinTheme: PinTheme(
                          errorBorderColor: Colors.red,
                          inactiveColor: const Color(0xffD5D6DD),
                          activeColor: ColorManager.backgroundColor,
                          selectedColor:ColorManager.backgroundColor,
                          borderWidth: 0.5,
                          shape: PinCodeFieldShape.box,
                          inactiveFillColor: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 80,
                          fieldWidth: 45,
                          activeFillColor: Colors.white,
                          selectedFillColor: Colors.white),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      autoFocus: false,
                      onCompleted: (v) {
                      },
                      onChanged: (value) {},
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    ),
                  ),
                  SizedBox(
                    height: size.height*.07,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomButton(
                        backgroundColor: ColorManager.secondColor,
                        buttonText:  tr(TextApp.next),
                        textColor: Colors.white,
                        isBuy: state is LoadingAccountStates,
                        onTap:(){
                          if(cubit.textEditingCodeController.text.isNotEmpty) {
                            cubit.verifyOtp(context, {
                              "email":email,
                              "otp_code":cubit.textEditingCodeController.text,
                            });
                            // cubit.verifyOTpApi(context, {
                            //   "phone":phoneNum,
                            //   "code":cubit.textEditingCodeController.text,
                            // });
                            // cubit.verifyOTP(cubit.textEditingCodeController.text);
                          }else{
                            appToast( message: TextApp.pleaseReturnCodeAndTryAgain.tr(), type: ToastType.error, context: context);
                          }

                        } ),
                  ),
                  SizedBox(
                    height: size.height*.12,
                  ),

                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(

                        onTap: (){
                          // cubit.verifyAccountApi(context, {
                          //   "email":email,
                          //   "password":password,
                          //   "otp_code":cubit.textEditingCodeController.text,
                          // });
                          // if(cubit.timeLeftInSec<10) {
                          //   // cubit.Login(phoneNum);
                          //   // cubit.timeLeftInSec = 180;
                          //   // cubit.ChangeStateOtp();
                          //   // cubit.startOrStop();
                          // }else{
                          //   // AppToasts.showFailureMessage("برجاء الإنتظار ثم اعادة الضغط");
                          // }
                          cubit.forgetPassword(context, email);
                        },
                        child: Text(TextApp.resend.tr(),
                          textAlign: TextAlign.end,

                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: ColorManager.backgroundColor,fontSize: FontSize.s17,),),
                      ),
                      SizedBox(width: 12,),
                      Text(TextApp.code_not_received.tr(),style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s16),),
                      SizedBox(width: 8,),

                      SizedBox(width: 12,),

                    ],),

                ],),
              ),
            ),
          );
        },
      ),
    );
  }
}
