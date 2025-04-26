// import 'package:cedem/presentation/bottom_nav_page/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';

// import '../../../component/styles_manager.dart';

class GeneralInformationScreen extends StatelessWidget {
  const GeneralInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          'General Information',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            buildLabel('User Name'),
            // buildTextField(cubit.userModel!=null?cubit.userModel!.data!.user!.name??"":""),
            // buildLabel('Full Name'),
            buildTextField('Muhamed Ahmed'),
            // buildLabel('Hold Area'),
            // buildFlagField(cubit.userModel!=null?cubit.userModel!.data!.user!.country!.name??"":""),
            // buildLabel('Role'),
            // buildTextField('User, Customer'),
            buildLabel('Email Address'),
            buildTextField("mohamed@gmail.com"),
            // buildTextField(cubit.userModel!=null?cubit.userModel!.data!.user!.email??"":""),
            buildLabel('Phone Number'),
            buildTextField("+9712111111111"),
            // buildTextField(cubit.userModel!=null?cubit.userModel!.data!.user!.mobile??"":""),
            const SizedBox(height: 32),
          ],
        ),
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
        style:  getBoldStyle( fontSize: 14, color: Colors.black),
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
        style:  getRegularStyle(
            color: Colors.black,
            fontSize: 14),
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
            style:  getRegularStyle(fontSize: 15, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
