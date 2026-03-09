import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/auth/sign_in/sign_in_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navigation_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/notification/notification_screen.dart';

import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded(child:Image.asset("assets/logo.png",scale: 5,),
          // Text(tr(TextApp.appName),

          // style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s22),)
          // ),
          // Expanded(child: SearchField()),
          Image.asset(
            "assets/logo.png",
            height: 50,
            width: 80,
            fit: BoxFit.fill,
          ),
          Spacer(),
          const SizedBox(width: 16),

          if (SharedPreferenceGetValue.getToken() != null &&
              SharedPreferenceGetValue.getToken() != "")
            IconBtnWithCounter(
              svgSrc: "assets/icons/Cart Icon.svg",
              press: () {
                navigateTo(
                    context,
                    BottomNavigationScreen(
                      startIndex: 2,
                    ));
              },
              // Navigator.pushNamed(context, CartScreen.routeName),
            ),
          const SizedBox(width: 8),
          if (SharedPreferenceGetValue.getToken() != null &&
              SharedPreferenceGetValue.getToken() != "")
            BlocBuilder<BottomNavigationCubit, BottomNavigationStates>(
                builder: (context, state) {
              return IconBtnWithCounter(
                svgSrc: "assets/icons/Bell.svg",
                numOfitem: BottomNavigationCubit.get(context).appSettingsResponse!=
                            null &&
                        BottomNavigationCubit.get(context)
                                .appSettingsResponse!
                                .data !=
                            null
                    &&
                        BottomNavigationCubit.get(context)
                                .appSettingsResponse!.data!
                                .unreadNotifications>
                            0
                    ? BottomNavigationCubit.get(context)
                        .appSettingsResponse!
                        .data!.unreadNotifications
                    : 0,
                press: () {
                  navigateTo(context, NotificationsScreen());
                },
              );
            }),


          /// login
          if (SharedPreferenceGetValue.getToken() == null ||
              SharedPreferenceGetValue.getToken() == "")
            IconBtnWithCounter(
              svgSrc: "assets/icons/User.svg",
              press: () {
                navigateTo(context, SignInScreen());
              },
              // Navigator.pushNamed(context, CartScreen.routeName),
            ),
        ],
      ),
    );
  }
}
