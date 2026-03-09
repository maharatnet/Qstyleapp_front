import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor, padding: const EdgeInsets.all(20),
          textStyle: getBoldStyle(color: Colors.black,fontSize: FontSize.s16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuDelete extends StatelessWidget {
  const ProfileMenuDelete({
    Key? key,
    required this.text,
    required this.icon,
    this.press,

  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor://ColorManager.error.withOpacity(.1),
          kPrimaryColor,
          padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 12),
          textStyle: getBoldStyle(color: Colors.black,fontSize: FontSize.s16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:icon.contains("User")?ColorManager.primary.withOpacity(.1): ColorManager.error.withOpacity(.1),
          // backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: icon.contains("User")?ColorManager.primary:ColorManager.error,
              // color: kPrimaryColor,
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text,style: getBoldStyle(color: icon.contains("User")?ColorManager.primary:ColorManager.error,fontSize: FontSize.s16),)),
             Icon(Icons.arrow_forward_ios,color:ColorManager.error ,),
          ],
        ),
      ),
    );
  }
}