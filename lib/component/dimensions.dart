import 'package:flutter/material.dart';

class Dimensions {
  static dynamic screenSize(BuildContext context) =>
      MediaQuery.sizeOf(context);
  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double heightPercentage(BuildContext context, double percentage) =>
      screenHeight(context) * percentage / 100;

  static double widthPercentage(BuildContext context, double percentage) =>
      screenWidth(context) * percentage / 100;

  static double fontSize(BuildContext context, double percentage) =>
      screenHeight(context) * percentage / 100;

  static double radius(BuildContext context, double percentage) =>
      screenHeight(context) * percentage / 100;

  static const double fontSizeExtraSmall = 10.0;
  static const double fontSizeSmall = 12.0;
  static const double fontSizeDefault13 = 13.0;

  static const double fontSizeDefault = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeExtraLarge = 18.0;
  static const double fontSizeOverLarge = 24.0;
  static const double fontSizeWallet = 24.0;

  static const double paddingSizeExtraExtraSmall = 2.0;
  static const double paddingSizeExtraSmall = 5.0;
  static const double paddingSizeEight = 8.0;
  static const double paddingSizeSmall = 10.0;
  static const double paddingSizeTwelve = 12.0;
  static const double paddingSizeDefault = 15.0;
  static const double homePagePadding = 16.0;
  static const double paddingSizeDefaultAddress = 17.0;
  static const double paddingSizeLarge = 20.0;
  static const double paddingSizeExtraLarge = 25.0;
  static const double paddingSizeThirtyFive = 35.0;
  static const double paddingSize40= 35.0;

  static const double paddingSizeOverLarge = 50.0;

  static const double marginSizeExtraSmall = 5.0;
  static const double marginSizeSmall = 10.0;
  static const double marginSizeDefault = 15.0;
  static const double marginSizeLarge = 20.0;
  static const double marginSizeExtraLarge = 25.0;
  static const double marginSizeAuthSmall = 30.0;
  static const double marginSizeAuth = 50.0;
  // static const double marginSizeAuth = 50.0;

  static const double iconSizeExtraSmall = 12.0;
  static const double iconSize15 = 15.0;

  static const double iconSizeSmall = 18.0;
  static const double iconSizeDefault20 = 20.0;

  static const double iconSizeDefault = 24.0;
  static const double iconSizeSemiLarge = 30.0;

  static const double iconSizeLarge = 32.0;
  static const double iconSizeExtraLarge = 40.0;
  static const double iconSize45 = 45.0;


  static const double imageSizeExtraSeventy = 70.0;
  static const double bannerPadding = 40.0;


  static const double topSpace = 30.0;
  static const double splashLogoWidth = 150.0;


  static const double chooseReviewImageSize = 40.0;
  static const double profileImageSize = 100.0;
  static const double logoHeight = 80.0;
  static const double cardHeight = 265.0;


  static const double radiusSmall = 5.0;

  static const double radius8 = 8;
  static const double radius9 = 9;

  static const double radiusDefault = 10.0;
  static const double radius12 = 12.5;

  static const double radiusLarge = 15.0;

  static const double radius16 = 16.0;

  static const double radius18 = 18.0;

  static const double radiusExtraLarge = 20.0;
  static const double radues25 = 25.0;
  static const double radues27 = 27.0;
  static const double radues29 = 29.0;
  static const double radues30 = 30.0;

  static const double raduesCircularAvatar32 = 32.0;
  static const double raduesCircularAvatar35 = 35.0;
  static const double raduesCircularAvatar37 = 37.0;


  static const double menuIconSize = 25.0;
  static const double featuredProductCard = 370.0;
  static const double compareCardWidget = 200.0;


  //sizedBox dimensions.....................*
  static const double sizedBox2 = 2.0;
  static const double sizedBox5 = 4.0;
  static const double sizedBox10 = 8.0;
  static const double sizedBox15 = 15.0;
  static const double sizedBox20 = 20.0;
  static const double sizedBox25 = 25.0;
  static const double sizedBox30 = 30.0;
  static const double sizedBox35 = 35.0;
  static const double sizedBox40 = 40.0;
  static const double sizedBox50 = 45.0;




}
