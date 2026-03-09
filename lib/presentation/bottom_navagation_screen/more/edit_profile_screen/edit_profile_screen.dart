// import 'package:cedem/presentation/bottom_nav_page/profile/profile_cubit.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/custom_button.dart';
import 'package:maharat_ecommerce/component/loading_image/image_component.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/auth/forget_password/verify_otp_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/edit_profile_screen/general_information_cubit.dart';
import 'package:shimmer/shimmer.dart';

// import '../../../component/styles_manager.dart';

class GeneralInformationScreen extends StatelessWidget {
  GeneralInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GeneralInformationCubit()..initData(),
      child: BlocConsumer<GeneralInformationCubit, GeneralInformationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = GeneralInformationCubit.get(context);
          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const BackButton(color: Colors.black),
              title: Text(
                tr(TextApp.generalInformation),
                style: getBoldStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: cubit.is_get_data==false?

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () async {
                      await cubit.pickImage(); // أو استدعاء الدالة مباشرة إذا ليست في Cubit
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                        image: cubit.selectedImage != null
                            ? DecorationImage(
                          image: FileImage(cubit.selectedImage!),
                          fit: BoxFit.cover,
                        )
                            : null,
                        color: Colors.grey[200],
                      ),
                      child:cubit.selectedImage != null?null: cubit.selectedImage == null&&cubit.imageUrl==""
                          ? Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                          : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ImageComponent(path: cubit.imageUrl??"")),
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildLabel(tr(TextApp.userName)),
                  // buildTextField(cubit.userModel!=null?cubit.userModel!.data!.user!.name??"":""),
                  // buildLabel('Full Name'),
                  // buildTextField('Muhamed Ahmed'),
                  buildTextFieldField(
                    controller: cubit.userNameController,
                    hint: TextApp.muhamedAhmed,
                    inputType: TextInputType.text,
                  ),
                  // buildLabel('Hold Area'),
                  // buildFlagField(cubit.userModel!=null?cubit.userModel!.data!.user!.country!.name??"":""),
                  // buildLabel('Role'),
                  // buildTextField('User, Customer'),
                  buildLabel(tr(TextApp.emailAddress)),
                  // buildTextField("mohamed@gmail.com"),
                  buildTextFieldField(
                      controller: cubit.emailController,
                      hint: TextApp.mohamedGmail,
                      inputType: TextInputType.emailAddress),
                  // buildTextField(cubit.userModel!=null?cubit.userModel!.data!.user!.email??"":""),
                  buildLabel(tr(TextApp.phoneNumber)),
                  // buildTextField("+9712111111111"),
                  // buildTextFieldField(
                // Text(cubit.isoCode),
                  buildPhoneField(
                    controller: cubit.phoneController,
                    countryCode: cubit.isoCode
                    // hint: '+9712111111111',
                    // inputType: TextInputType.phone,
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: cubit.selectedGender,
                        onChanged: (value) {
                          cubit.selectedGender = value!;
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
                          cubit.selectedGender = value!;
                          cubit.refreshData();
                        },
                      ),
                       Text(tr(TextApp.female)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    isBuy: state is LoadingUpdateGetStates,
                    onTap: ()async{
                      Map<String,dynamic> data =   {
                        "name":cubit.userNameController.text,
                        "email":cubit.emailController.text,
                        "mobile":cubit.phoneController.text,
                        "gender":cubit.selectedGender,

                      };
                      if(cubit.selectedImage!=null){
                        data["photo_profile"] = await  MultipartFile.fromFile(
                            cubit.selectedImage!.path!,
                            filename: cubit.selectedImage!.path.split("/").last);
                      }
                      cubit.updateProfileApi(context,data);
                    },
                      textColor: ColorManager.white,
                      backgroundColor: ColorManager.primary,
                      buttonText: tr(TextApp.updateInformation)),
                  // buildTextField(cubit.userModel!=null?cubit.userModel!.data!.user!.mobile??"":""),
                  const SizedBox(height: 20),
                  CustomButton(
                    // isBuy: state is LoadingUpdateGetStates,
                    onTap: ()async{
                      navigateTo(context, VerfiyOtpScreen(email: cubit.emailController.text,));
                    },
                      textColor: ColorManager.white,
                      backgroundColor: ColorManager.primary,
                      buttonText: tr(TextApp.change_password)),
                  // buildTextField(cubit.userModel!=null?cubit.userModel!.data!.user!.mobile??"":""),
                  const SizedBox(height: 32),
                ],
              ):

              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    buildLabel(tr(TextApp.userName)),
                    buildTextFieldField(
                      controller: cubit.userNameController,
                      hint: TextApp.muhamedAhmed,
                      inputType: TextInputType.text,
                    ),
                    buildLabel(TextApp.emailAddress),
                    buildTextFieldField(
                        controller: cubit.emailController,
                        hint: TextApp.mohamedGmail,
                        inputType: TextInputType.emailAddress),
                    buildLabel(TextApp.phoneNumber),
                    buildPhoneField(
                      controller: cubit.phoneController,
                      countryCode: cubit.isoCode,
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: cubit.selectedGender,
                          onChanged: (value) {
                            cubit.selectedGender = value!;
                            cubit.refreshData();
                          },
                        ),
                        Text(tr(TextApp.male)),
                        SizedBox(width: 20),
                        Radio<String>(
                          value: 'Female',
                          groupValue: cubit.selectedGender,
                          onChanged: (value) {
                            cubit.selectedGender = value!;
                            cubit.refreshData();
                          },
                        ),
                        Text(tr(TextApp.female)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomButton(

                        textColor: ColorManager.white,
                        backgroundColor: ColorManager.primary,
                        buttonText: tr(TextApp.updateInformation)),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    // return BlocProvider(create: (_)=>ProfileCubit()..initState(),
    //     child: BlocConsumer<ProfileCubit,ProfileStates>(
    //       builder: (context,state)
    //       {
    //         final cubit = ProfileCubit.get(context);
    //         return Scaffold(
    //           backgroundColor: const Color(0xFFF5F5F5),
    //           appBar: AppBar(
    //             backgroundColor: Colors.transparent,
    //             elevation: 0,
    //             leading: const BackButton(color: Colors.black),
    //             title: Text(
    //               'General Information',
    //               style: getBoldStyle(
    //                 color: Colors.black,
    //                 // fontWeight: FontWeight.bold,
    //                 fontSize: 16,
    //               ),
    //             ),
    //             centerTitle: false,
    //           ),
    //           body: SingleChildScrollView(
    //             padding: const EdgeInsets.symmetric(horizontal: 16),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const SizedBox(height: 16),
    //                 buildLabel('User Name'),
    //                 buildTextField(cubit.userModel!=null?cubit.userModel!.data!.user!.name??"":""),
    //                 // buildLabel('Full Name'),
    //                 // buildTextField('Muhamed Ahmed'),
    //                 buildLabel('Hold Area'),
    //                 buildFlagField(cubit.userModel!=null?cubit.userModel!.data!.user!.country!.name??"":""),
    //                 // buildLabel('Role'),
    //                 // buildTextField('User, Customer'),
    //                 buildLabel('Email Address'),
    //                 buildTextField(cubit.userModel!=null?cubit.userModel!.data!.user!.email??"":""),
    //                 buildLabel('Phone Number'),
    //                 buildTextField(cubit.userModel!=null?cubit.userModel!.data!.user!.mobile??"":""),
    //                 const SizedBox(height: 32),
    //               ],
    //             ),
    //           ),
    //         );
    //       }, listener: (context, state) {  },));
  }

  Widget buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        label,
        style: getBoldStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

  Widget buildTextField(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 45,
      alignment: Alignment.centerLeft,
      child: Text(
        value,
        style: getRegularStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }

  Widget buildFlagField(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 45,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          // const Text('🇪🇬', style: TextStyle(fontSize: 20)),
          // const SizedBox(width: 8),
          Text(
            value.replaceAll('🇪🇬 ', ''),
            style: getRegularStyle(fontSize: 15, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

Widget buildTextFieldField({
  required TextEditingController controller,
  required String hint,
  TextInputType inputType = TextInputType.text,
}) {
  return Container(
    height: 45,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    alignment: Alignment.center,
    child: TextFormField(
      controller: controller,
      keyboardType: inputType,
      style: getRegularStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: getRegularStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        border: InputBorder.none,
      ),
    ),
  );
}

Widget buildPhoneField({
  required TextEditingController controller,
  String countryCode ='AE',
}) {
  return Container(
    height: 45,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    alignment: Alignment.center,
    child: IntlPhoneField(
      controller: controller,
      initialCountryCode:countryCode ,
      style: getRegularStyle(fontSize: 14, color: Colors.black),
      dropdownTextStyle: getRegularStyle(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        hintText: tr(TextApp.enterPhoneNumber),
        hintStyle: getRegularStyle(color: Colors.grey, fontSize: 14),
        border: InputBorder.none,
      ),
      disableLengthCheck: true,
      onChanged: (phone) {
        print(phone.completeNumber);
      },
    ),
  );
}
