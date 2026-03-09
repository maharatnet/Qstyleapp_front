import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navigation_cubit.dart';


const Color inActiveIconColor = Color(0xFFB6B6B6);

class BottomNavigationScreen extends StatelessWidget {
   int startIndex;
   BottomNavigationScreen({super.key,  this.startIndex =0});

  static String routeName = "/";

  // int currentSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>BottomNavigationCubit()
      ..updateCurrentIndex(startIndex)
      ..getNotificationApi(context)
      ..getBannerApi(context)
      ..getCategoryApi(context,0),
    child:
    BlocConsumer<BottomNavigationCubit,BottomNavigationStates>(
        listener: (context,state){},
       builder: (context,state){
          final cubit = BottomNavigationCubit.get(context);
          return Scaffold(
            body: cubit.pages[ cubit.startIndex],
            // body: pages[currentSelectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: cubit.updateCurrentIndex,
              currentIndex:  startIndex,
              // currentIndex: currentSelectedIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    color: inActiveIconColor,
                    // colorFilter: const ColorFilter.mode(
                    //   inActiveIconColor,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    color: ColorManager.secondColor,
                    // colorFilter:  ColorFilter.mode(
                    //   ColorManager.secondColor,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                  label: tr(TextApp.home),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Heart Icon.svg",
                    color: inActiveIconColor,
                    // colorFilter: const ColorFilter.mode(
                    //   inActiveIconColor,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/Heart Icon.svg",
                    color: ColorManager.secondColor,
                    // colorFilter:  ColorFilter.mode(
                    //   ColorManager.secondColor,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                  label: tr(TextApp.favorite),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Cart Icon.svg",
                    color: inActiveIconColor,
                    // colorFilter: const ColorFilter.mode(
                    //   inActiveIconColor,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/Cart Icon.svg",
                    color:                       ColorManager.secondColor,
         // colorFilter:  ColorFilter.mode(
                    //   ColorManager.secondColor,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                  label: tr(TextApp.cart),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/User Icon.svg",
                    color: inActiveIconColor,
                    // colorFilter: const ColorFilter.mode(
                    //   inActiveIconColor,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/User Icon.svg",
                    color: ColorManager.secondColor,
                    // colorFilter:  ColorFilter.mode(
                    //   ColorManager.secondColor,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                  label: tr(TextApp.profile),
                ),
              ],
            ),
          );
       },
    ),
    );
  }
}
