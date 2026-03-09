import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/not_login/card_not_login.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/network/cache_helper.dart';
import 'package:maharat_ecommerce/presentation/auth/sign_in/sign_in_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navigation_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/edit_profile_screen/edit_profile_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/my_location/location_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/notification/notification_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/setting/setting_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/my_order_screen/my_order_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/profile/about_us_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/profile/component/profile_menu.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/profile/component/profile_pic.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/profile/terms_condition_screen.dart';


import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cubitBottom  = BottomNavigationCubit.get(context);
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [

              Container(
                height:SharedPreferenceGetValue.getToken()!=null&&SharedPreferenceGetValue.getToken()!=""?120: 140,
                child:SharedPreferenceGetValue.getToken()!=null&&SharedPreferenceGetValue.getToken()!=""?
                CardLoginScreen(): CardNotLoginScreen(),
              ),
              // const ProfilePic(),
              const SizedBox(height: 20),
              if(SharedPreferenceGetValue.getToken()!=null&&SharedPreferenceGetValue.getToken()!="")
                ProfileMenu(
                text: tr(TextApp.myAccount),
                icon: "assets/icons/User Icon.svg",
                press: () {
                  navigateTo(context, GeneralInformationScreen());
                },
              ),
              if(SharedPreferenceGetValue.getToken()!=null&&SharedPreferenceGetValue.getToken()!="")

                ProfileMenu(
                text: tr(TextApp.my_orders),
                icon: "assets/icons/orders-icon.svg",
                press: () {
                  navigateTo(context, MyOrdersScreen());
                },
              ),
              if(SharedPreferenceGetValue.getToken()!=null&&SharedPreferenceGetValue.getToken()!="")

                ProfileMenu(
                text: tr(TextApp.notifications),
                icon: "assets/icons/Bell.svg",
                press: () {
                  navigateTo(context, NotificationsScreen());
                },
              ),
              ProfileMenu(
                text: tr(TextApp.language),
                // text: "Settings",
                icon: "assets/icons/Settings.svg",
                press: () {
                  navigateTo(context, SettingsScreen());
                },
              ),
              if(SharedPreferenceGetValue.getToken()!=null&&SharedPreferenceGetValue.getToken()!="")

                ProfileMenu(
                // text: "Support",
                text: tr(TextApp.location),
                icon: "assets/icons/maps-pin-line-icon.svg",
                press: () {
                  navigateTo(context, MyLocationScreen());
                },
              ),
              if(SharedPreferenceGetValue.getToken()==null||SharedPreferenceGetValue.getToken()=="")

                ProfileMenuDelete(
                text: tr(TextApp.login),
                icon: "assets/icons/User.svg",
                press: () {
                  navigateTo(context, SignInScreen());

                },
              ),
             if(cubitBottom.appSettingsResponse!=null&&cubitBottom!.appSettingsResponse!.data!=null&&cubitBottom!.appSettingsResponse!.data!.about!=null&&cubitBottom!.appSettingsResponse!.data!.about!.isNotEmpty)
              ProfileMenu(
                text: tr(TextApp.aboutApp),
                icon: "assets/icons/info.svg",
                press: () {
                  navigateTo(context, const AboutAppScreen());
                },
              ),
              if(cubitBottom.appSettingsResponse!=null&&cubitBottom!.appSettingsResponse!.data!=null&&cubitBottom!.appSettingsResponse!.data!.terms!=null&&cubitBottom!.appSettingsResponse!.data!.terms!.isNotEmpty)
              ProfileMenu(
                text: tr(TextApp.termsConditions),
                icon: "assets/icons/file-text.svg",
                press: () {
                  navigateTo(context, const TermsConditionsScreen());
                },
              ),
              socialMediaSection(cubitBottom),
              if(SharedPreferenceGetValue.getToken()!=null&&SharedPreferenceGetValue.getToken()!="")
              ProfileMenuDelete(
                text: tr(TextApp.logOut),
                icon: "assets/icons/Log out.svg",
                press: () {
                  _confirmLogout(context);
                },
              ),
              if(SharedPreferenceGetValue.getToken()!=null&&SharedPreferenceGetValue.getToken()!="")
                ProfileMenuDelete(
                text: tr(TextApp.deleteAccount),
                icon: "assets/icons/remove.svg",
                press: () {
                  _confirmLogoutDelete(context);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
Widget socialMediaSection(var cubitBottom) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(cubitBottom.appSettingsResponse!=null&&cubitBottom!.appSettingsResponse!.data!=null&&cubitBottom!.appSettingsResponse!.data!.facebook!=null&&cubitBottom!.appSettingsResponse!.data!.facebook.isNotEmpty)
          IconButton(
          icon: Image.asset("assets/icons/facebook.png", width: 32),
          // icon: Image.asset("assets/icons/facebook.png", width: 28),
          onPressed: () => openUrl(cubitBottom!.appSettingsResponse!.data!.facebook??"https://facebook.com/yourpage"),
        ),
        if(cubitBottom.appSettingsResponse!=null&&cubitBottom!.appSettingsResponse!.data!=null&&cubitBottom!.appSettingsResponse!.data!.instagram!=null&&cubitBottom!.appSettingsResponse!.data!.instagram.isNotEmpty)
          IconButton(
          icon: Image.asset("assets/icons/instagram.png", width: 32),
          // icon: Image.asset("assets/icons/instagram.png", width: 28),
          onPressed: () => openUrl(cubitBottom!.appSettingsResponse!.data!.instagram??"https://instagram.com/yourpage"),
        ),
        if(cubitBottom.appSettingsResponse!=null&&cubitBottom!.appSettingsResponse!.data!=null&&cubitBottom!.appSettingsResponse!.data!.twitter!=null&&cubitBottom!.appSettingsResponse!.data!.twitter.isNotEmpty)

          IconButton(
          icon: Image.asset("assets/icons/twitter.png", width: 32),
          // icon: Image.asset("assets/icons/twitter.png", width: 28),
          onPressed: () => openUrl(cubitBottom!.appSettingsResponse!.data!.twitter??"https://twitter.com/yourpage"),
        ),
        if(cubitBottom.appSettingsResponse!=null&&cubitBottom!.appSettingsResponse!.data!=null&&cubitBottom!.appSettingsResponse!.data!.telegram!=null&&cubitBottom!.appSettingsResponse!.data!.telegram.isNotEmpty)
          IconButton(
          icon: Image.asset("assets/icons/telegram.png", width: 32),
          // icon: Image.asset("assets/icons/telegram.png", width: 28),
          onPressed: () => openUrl(cubitBottom!.appSettingsResponse!.data!.telegram??"https://t.me/yourchannel"),
        ),
      ],
    ),
  );
}

void _confirmLogout(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(tr(TextApp.confirmLogout),style: getBoldStyle(color: Colors.black,fontSize: FontSize.s18)),
      content: Text(tr(TextApp.are_you_sure_want_logout),style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16),),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // إلغاء
          },
          child: Text(tr(TextApp.cancel),style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16)),
        ),
        TextButton(
          onPressed: () {
            // Navigator.of(context).pop();
            _logout(context);
          },
          child: Text(tr(TextApp.logOut),style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16)),
        ),
      ],
    ),
  );
}
void _confirmLogoutDelete(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(tr(TextApp.confirmDelete),style: getBoldStyle(color: Colors.black,fontSize: FontSize.s18)),
      content: Text(tr(TextApp.are_you_sure_want_delete),style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16),),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // إلغاء
          },
          child: Text(tr(TextApp.cancel),style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16)),
        ),
        TextButton(
          onPressed: () {
            // Navigator.of(context).pop();
            _logout(context);
          },
          child: Text(tr(TextApp.delete),style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16)),
        ),
      ],
    ),
  );
}
void _logout(BuildContext context) {
  CacheHelper.removeData(key: "tokenUser").then((e){
    CacheHelper.removeData(key: "NameProfile");
    // Navigator.of(context).pop();
    navigateAndFinish(context, SignInScreen());
  });
}