import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/network/cache_helper.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/edit_profile_screen/edit_profile_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/notification/notification_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/setting/setting_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/profile/component/profile_menu.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/profile/component/profile_pic.dart';



class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title:  Text("Profile",style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s18),),
        // ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                height: 120,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24)
                    )
                ),
                child: Stack(
                  children: [
                    Align(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 10,),
                              Text("Profile",style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s18),),
                              SizedBox(width: 10,),
                            ],
                          ),
                          SizedBox(height: 8),
                          // Container(
                          //   height: 60,
                          //   width: 60,
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       color: ColorManager.white
                          //   ),
                          // ),
                          SizedBox(height: 8),
                          Text(
                            // SharedPreferenceGetValue.getNameProfile(),
                            'Muhamed Ahmed',
                            style: getBoldStyle(
                              color: Colors.white,
                              fontSize: 16,),
                          ),
                          SizedBox(height: 4),
                          // Text(
                          //   'Customer in Egypt',
                          //   style: getBoldStyle(
                          //       fontSize: 14, color: Colors.grey),
                          // ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
              // const ProfilePic(),
              const SizedBox(height: 20),
              ProfileMenu(
                text: "My Account",
                icon: "assets/icons/User Icon.svg",
                press: () {
                  navigateTo(context, GeneralInformationScreen());
                },
              ),
              ProfileMenu(
                text: "Notifications",
                icon: "assets/icons/Bell.svg",
                press: () {
                  navigateTo(context, NotificationsScreen());
                },
              ),
              ProfileMenu(
                text: "Settings",
                icon: "assets/icons/Settings.svg",
                press: () {
                  navigateTo(context, SettingsScreen());
                },
              ),
              ProfileMenu(
                // text: "Support",
                text: "Help Center",
                icon: "assets/icons/Question mark.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/icons/Log out.svg",
                press: () {
                  _confirmLogout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _confirmLogout(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Confirm Logout',style: getBoldStyle(color: Colors.black,fontSize: FontSize.s18)),
      content: Text('Are you sure you want to Logout ?',style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16),),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // إلغاء
          },
          child: Text('Cancel',style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            // _logout(context);
          },
          child: Text('Logout',style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16)),
        ),
      ],
    ),
  );
}

void _logout(BuildContext context) {
  CacheHelper.removeData(key: "tokenUser").then((e){
    Navigator.of(context).pop();
    // navigateAndFinish(context, LoginScreen());
  });
}