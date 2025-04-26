//
//
// import 'package:gold_market/component/bottom_sheet/logout_custom_bottom_sheet.dart';
// import 'package:gold_market/component/button/custom_button_widget.dart';
// import 'package:gold_market/component/color_manger.dart';
// import 'package:gold_market/component/component.dart';
// import 'package:gold_market/component/dimensions.dart';
// import 'package:gold_market/component/font_manager.dart';
// import 'package:gold_market/component/image_assets.dart';
// import 'package:gold_market/component/styles_manager.dart';
// import 'package:gold_market/component/values_manager.dart';
// import 'package:gold_market/helper/sharedprefrenece_value.dart';
// import 'package:gold_market/presentation/screen/auth/login/login_screen.dart';
// import 'package:gold_market/presentation/screen/free_course/study_schedule_screen.dart';
// import 'package:gold_market/presentation/screen/more_screen/about_us/about_us_screen.dart';
// import 'package:gold_market/presentation/screen/more_screen/articles/articles_screen.dart';
// import 'package:gold_market/presentation/screen/more_screen/basket/basket_screen.dart';
// import 'package:gold_market/presentation/screen/more_screen/common_question/common_question_view.dart';
// import 'package:gold_market/presentation/screen/more_screen/contact_us/contact_us_screen.dart';
// import 'package:gold_market/presentation/screen/more_screen/my_order/my_order_screen.dart';
// import 'package:gold_market/presentation/screen/more_screen/notification/notification_screen.dart';
// import 'package:gold_market/presentation/screen/more_screen/privacy/privacy_screen.dart';
// import 'package:gold_market/presentation/screen/more_screen/team_work/team_work_view.dart';
// import 'package:gold_market/presentation/screen/more_screen/terms_and_conditions/terms_and_conditions_screen.dart';
// import 'package:gold_market/presentation/screen/start_page/cubit/start_cubit.dart';
// import 'package:gold_market/presentation/widget/footer_widget.dart';
// import 'package:gold_market/presentation/widget/join_us.dart';
// import 'package:gold_market/presentation/widget/said_about.dart';
// import 'package:flutter/material.dart';
//
// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.sizeOf(context);
//     return
//         // Directionality(
//         // textDirection: TextDirection.rtl,
//         // child:
//         Drawer(
//           width: size.width*.6,
//       child: SingleChildScrollView(
//         child: Container(
//
//           child: Column(
//             // Important: Remove any padding from the ListView.
//             // padding: EdgeInsets.zero,
//             children: [
//
//               SizedBox(height: 8,),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   height: 80,
//                   width: 120,
//                   decoration: BoxDecoration(
//                       // color: ColorManager.backgroundColor,
//                       borderRadius: BorderRadius.circular(4),
//                       // border: Border.all(color: ColorManager.black),
//                       image: DecorationImage(
//                           image: AssetImage(ImageAssets.logo),
//                           fit: BoxFit.contain)),
//                 ),
//               ),
//               SizedBox(
//                 height: 12,
//               ),
//
//
//               CustomDrawerIcon(text: "السلة",icon: Icons.shopping_cart,onTap: (){
//                 navigateTo(context, BasketScreen());
//               }),
//               CustomDrawerIcon(text: "مشترياتى",icon: Icons.bookmarks_sharp,onTap: (){
//                 navigateTo(context, MyOrderScreen());
//               }),
//               CustomDrawerIcon(text: "الإشعارات",icon: Icons.notifications,onTap: (){
//                 navigateTo(context, NotificationScreen());
//               }),
//               CustomDrawerIcon(text: "الاسئلة الشائعة",icon: Icons.numbers,onTap: (){
//                 navigateTo(context, CommonQuestionView());
//               }),
//               CustomDrawerIcon(text: "فريق العمل",icon: Icons.work_history_outlined,onTap: (){
//                 navigateTo(context, TeamWorkView());
//               }),
//               // CustomDrawerIcon(text: "انضم لفريق العمل",icon: Icons.work,onTap: (){}),
//               // CustomDrawerIcon(text: "انضم لفريق المسوقين",icon: Icons.join_inner,onTap: (){}),
//               CustomDrawerIcon(text: "المقالات",icon: Icons.article,onTap: (){
//                 navigateTo(context, ArticlesScreen());
//               }),
//
//               CustomDrawerIcon(text: "قالوا عنا",icon: Icons.safety_divider,onTap: (){
//                 navigateTo(context, Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: Scaffold(
//                       appBar: AppBar(
//                         centerTitle: true,
//                         title: Text("قالوا عنا",style: getBoldStyle(color: ColorManager.backgroundColor,fontSize: FontSize.s18),),
//                       ),
//                       body: SaidAbout(homeModel: StartCubit.get(context).homeModel,)),
//                 ));
//               }),
//               CustomDrawerIcon(text: "انضم الينا",icon: Icons.join_full,onTap: (){
//                 navigateTo(context, ContactUsScreen());
//                 // navigateTo(context, Directionality(
//                 //   textDirection: TextDirection.rtl,
//                 //   child: Scaffold(
//                 //       appBar: AppBar(
//                 //         centerTitle: true,
//                 //         title: Text("انضم الينا",style: getBoldStyle(color: ColorManager.backgroundColor,fontSize: FontSize.s18),),
//                 //       ),
//                 //       body: JoinUsWidget(homeModel: StartCubit.get(context).homeModel,showOnly: true,)),
//                 // ));
//               }),
//               CustomDrawerIcon(text: "تواصل معنا",icon: Icons.call_to_action,onTap: (){
//                 navigateTo(context, Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: Scaffold(
//                       appBar: AppBar(
//                         centerTitle: true,
//                         title: Text("تواصل معنا",style: getBoldStyle(color: ColorManager.backgroundColor,fontSize: FontSize.s18),),
//                       ),
//                       body: FooterWidget(homeModel: StartCubit.get(context).homeModel,)),
//                 ));
//               }),
//               CustomDrawerIcon(text: "الخصوصية",icon: Icons.article,onTap: (){
//                 navigateTo(context, PrivacyScreen());
//               }),
//               CustomDrawerIcon(text: "الشروط والاحكام",icon: Icons.article,onTap: (){
//                 navigateTo(context, TermsAndConditionsScreen());
//               }),
//               CustomDrawerIcon(text: "عن اليسر",icon: Icons.article,onTap: (){
//                 navigateTo(context, AboutUsScreen());
//               }),
//
//     Container(
//       height: 4,
//     ),
//     // Padding(
//               //   padding: const EdgeInsets.all(AppPadding.p11),
//               //   child: CustomButtonWidget(
//               //     width: size.width,
//               //     color: ColorManager.backgroundColor,
//               //     height: 54,
//               //     text: "جدول المزاكرة",
//               //     onTap: (){
//               //       navigateTo(context,StudyScheduleScreen());
//               //     },
//               //   ),
//               // ),
//               //
//               // Padding(
//               //   padding: const EdgeInsets.all(AppPadding.p11),
//               //   child: CustomButtonWidget(
//               //     width: size.width,
//               //     color: ColorManager.backgroundColor,
//               //     height: 54,
//               //     text: "المقالات",
//               //     onTap: (){
//               //       navigateTo(context, ArticlesScreen());
//               //     },
//               //   ),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(AppPadding.p11),
//               //   child: CustomButtonWidget(
//               //     width: size.width,
//               //     color: ColorManager.backgroundColor,
//               //     height: 54,
//               //     text: "قالوا عنا",
//               //     onTap: (){
//               //       navigateTo(context, Directionality(
//               //         textDirection: TextDirection.rtl,
//               //         child: Scaffold(
//               //             appBar: AppBar(
//               //               centerTitle: true,
//               //               title: Text("قالوا عنا",style: getBoldStyle(color: ColorManager.backgroundColor,fontSize: FontSize.s18),),
//               //             ),
//               //             body: SaidAbout(homeModel: StartCubit.get(context).homeModel,)),
//               //       ));
//               //     },
//               //   ),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(AppPadding.p11),
//               //   child: CustomButtonWidget(
//               //     width: size.width,
//               //     color: ColorManager.backgroundColor,
//               //     height: 54,
//               //     text: "انضم الينا",
//               //     onTap: (){
//               //       navigateTo(context, Directionality(
//               //         textDirection: TextDirection.rtl,
//               //         child: Scaffold(
//               //             appBar: AppBar(
//               //               centerTitle: true,
//               //               title: Text("انضم الينا",style: getBoldStyle(color: ColorManager.backgroundColor,fontSize: FontSize.s18),),
//               //             ),
//               //             body: JoinUsWidget(homeModel: StartCubit.get(context).homeModel,showOnly: true,)),
//               //       ));
//               //     },
//               //   ),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(AppPadding.p11),
//               //   child: CustomButtonWidget(
//               //     width: size.width,
//               //     color: ColorManager.backgroundColor,
//               //     height: 54,
//               //     text: "تواصل معنا",
//               //     onTap: (){
//               //       navigateTo(context, Directionality(
//               //         textDirection: TextDirection.rtl,
//               //         child: Scaffold(
//               //             appBar: AppBar(
//               //               centerTitle: true,
//               //               title: Text("تواصل معنا",style: getBoldStyle(color: ColorManager.backgroundColor,fontSize: FontSize.s18),),
//               //             ),
//               //             body: FooterWidget(homeModel: StartCubit.get(context).homeModel,)),
//               //       ));
//               //     },
//               //   ),
//               // ),
//               Container(
//                 color: ColorManager.white,
//                 child: ListTile(
//
//                   leading: SizedBox(width: 30, child: Image.asset(ImageAssets.LogoutIcon, color: Theme.of(context).primaryColor,)),
//                   title: Text(SharedPreferenceGetValue.getToken()==""? 'تسجيل الدخول' : 'تسجيل الخروج',
//                       style: getBoldStyle(color: ColorManager.black,fontSize: Dimensions.fontSizeLarge)),
//                   onTap: (){
//                     if(SharedPreferenceGetValue.getToken()==""){
//                       navigateTo(context, LoginScreen());
//                     }else{
//                       showModalBottomSheet(backgroundColor: Colors.transparent,
//                           context: context, builder: (_)=>  const LogoutCustomBottomSheet());
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     )
//         // )
//         ;
//   }
// }
//
// Widget CustomDrawerIcon({required String text, required IconData icon,required Function() onTap}){
//   return        GestureDetector(
//     onTap: (){
//       onTap();
//     },
//     child: Card(
//       elevation: 1,
//       child: Container(
//         height: 52,
//         width: 170,
//         margin: EdgeInsets.only(left: 12,right: 12),
//         child: Row(children: [
//           // SizedBox(width: 10,),
//
//           Text(text,style: getBoldStyle(color: ColorManager.backgroundColor,fontSize: FontSize.s16),),
//           Spacer(),
//           Icon(icon,color: ColorManager.backgroundColor,),
//           SizedBox(width: 4,),
//         ],),
//       ),
//     ),
//   );
// }