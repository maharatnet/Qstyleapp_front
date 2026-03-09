import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navigation_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/children_category_widget.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/female_category_widget.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/men_category_widget.dart';


class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>BottomNavigationCubit()..getCategoryApi(context,1),
      child: BlocConsumer<BottomNavigationCubit, BottomNavigationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BottomNavigationCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    if(cubit.is_category_data)
                      CustomCategoryShimmerWidget(),
                    if(!cubit.is_category_data&&cubit.categoryResponseModel!=null)
                      for(int i=0;i<cubit.categoryList!.length;i++)...{
                        CustomCategoryWidget(
                          categoryModel: cubit.categoryList![i],

                        ),
                      },

                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap:(int i){
                cubit.updateCurrentIndexBrand(i,context);
              } ,
              currentIndex:  cubit.startIndex,
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
