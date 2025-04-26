import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/cart/cart_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/favourite/favourite_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/home_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/profile/profile_screen.dart';
// import 'package:shop_app/constants.dart';
// import 'package:shop_app/screens/favorite/favorite_screen.dart';
// import 'package:shop_app/screens/home/home_screen.dart';
// import 'package:shop_app/screens/profile/profile_screen.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class BottomNavigationScreen extends StatefulWidget {
   int startIndex;
   BottomNavigationScreen({super.key,  this.startIndex =0});

  static String routeName = "/";

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  // int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      widget.startIndex = index;
      // currentSelectedIndex = index;
    });
  }

  final pages = [
    const HomeScreen(),
    const FavouriteScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[ widget.startIndex],
      // body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex:  widget.startIndex,
        // currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              colorFilter:  ColorFilter.mode(
                ColorManager.secondColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",
              colorFilter:  ColorFilter.mode(
                ColorManager.secondColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Fav",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Cart Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Cart Icon.svg",
              colorFilter:  ColorFilter.mode(
                ColorManager.secondColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter:  ColorFilter.mode(
                ColorManager.secondColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Fav",
          ),
        ],
      ),
    );
  }
}
