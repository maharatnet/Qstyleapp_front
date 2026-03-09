import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/loading_image/image_component.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/home/category_response_model.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/category_item_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/screen/brand_screen.dart';
import 'package:shimmer/shimmer.dart';

import 'section_title.dart';

class CustomCategoryWidget extends StatelessWidget {
  CategoryModel? categoryModel;
  bool is_home ;
  CustomCategoryWidget({
    Key? key,
    this.categoryModel,
    this.is_home= false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: SectionTitle(
        //     title: "Female Category",
        //     press: () {},
        //   ),
        // ),
        CategoryOfferCard(
          image:categoryModel!.image??"",  //"assets/images/Image Banner 2.png",
          category:categoryModel!.name??"", //TextApp.women_category,
          numOfBrands: categoryModel!.subcategories!.length,
          press: () {
            // Navigator.pushNamed(context, ProductsScreen.routeName);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(

          children: categoryModel!.subcategories!
              .map((e) => Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        // print("is_home ${is_home}");
                        if(is_home) {
                          navigateTo(
                              context, CategoryItemScreen(categoryId: e.id ?? 1,
                            brandList: e.brands!.where((e) =>
                            e.isInterantional == 0).toList(),
                            is_international: 0,
                          ));
                        }else{
                          navigateTo(
                              context, CategoryItemScreen(categoryId: e.id ?? 1,
                            brandList: e.brands!.where((e) =>
                            e.isInterantional == 1).toList(),
                          is_international: 1,
                          ),
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * .24,
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1.02,
                              child: Container(
                                // padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: kSecondaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                    child: ImageComponent(path: e.image??"",)),
                                // Image.asset(e.image??""),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              e.name ?? "",
                              style: getBoldStyle(
                                  color: Colors.black, fontSize: FontSize.s16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),

        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //
        //       SpecialOfferCard(
        //         image: "assets/images/Image Banner 3.png",
        //         category: "Fashion",
        //         numOfBrands: 24,
        //         press: () {
        //           // Navigator.pushNamed(context, ProductsScreen.routeName);
        //         },
        //       ),
        //       const SizedBox(width: 20),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

List<CategoryHomeModel> dataList = [
  CategoryHomeModel(
    name: TextApp.clothes,
    image: "assets/images/ps4_console_white_1.png",
  ),
  CategoryHomeModel(
    name: TextApp.shoes,
    image: "assets/images/ps4_console_white_2.png",
  ),
  CategoryHomeModel(
    name: TextApp.watch,
    image: "assets/images/ps4_console_white_3.png",
  ),
  CategoryHomeModel(
    name: TextApp.perfumes,
    image: "assets/images/ps4_console_white_4.png",
  ),
  CategoryHomeModel(
    name: TextApp.clothes,
    image: "assets/images/ps4_console_white_4.png",
  ),
];

class CategoryOfferCard extends StatelessWidget {
  const CategoryOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [

                ImageComponent(path: image??"",
                fit: BoxFit.fill,
                  width: MediaQuery.sizeOf(context).width,
                ),
                // Image.asset(
                //   image,
                //   fit: BoxFit.cover,
                // ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: getBoldStyle(fontSize: 18, color: Colors.white
                              // fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextSpan(
                            text: "$numOfBrands ${tr(TextApp.brand)}",
                            style: getBoldStyle(
                                color: Colors.white, fontSize: FontSize.s14))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryOfferCardImageAsset extends StatelessWidget {
  const CategoryOfferCardImageAsset({
    Key? key,
    required this.press,
    required this.color,
  }) : super(key: key);


  final GestureTapCallback press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 140,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.asset( "assets/images/brands.jpg",
                    fit: BoxFit.fill,

                    width: MediaQuery.sizeOf(context).width,
                  ),
                ),
                // Image.asset(
                //   image,
                //   fit: BoxFit.cover,
                // ),
                Container(
                  decoration:  BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        color, // ColorManager.secondColor,
                        color.withOpacity(.7),  // ColorManager.secondColor.withOpacity(.7),
                        color.withOpacity(.5),  // ColorManager.secondColor.withOpacity(.5),
                        color.withOpacity(.7),  // ColorManager.secondColor.withOpacity(.7),
                        // Colors.black54,
                        // Colors.black38,
                        // Colors.black26,
                        // Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(tr(TextApp.LUXURY),style: getBoldStyle(fontSize: 20, color: Colors.black
                        // fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  // child: Text.rich(
                  //   TextSpan(
                  //     style: const TextStyle(color: Colors.black),
                  //
                  //     children: [
                  //       TextSpan(
                  //         text: "LUXURY",
                  //
                  //         style: getBoldStyle(fontSize: 18, color: Colors.black
                  //           // fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       // TextSpan(
                  //       //     text: "$numOfBrands ${TextApp.brand}",
                  //       //     style: getBoldStyle(
                  //       //         color: Colors.white, fontSize: FontSize.s14))
                  //     ],
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryHomeModel {
  String name;
  String image;

  CategoryHomeModel({required this.name, required this.image});
}

class CustomCategoryShimmerWidget extends StatelessWidget {
  const CustomCategoryShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Banner Shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Grid Items Shimmer
        Wrap(
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.sizeOf(context).width * .24,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.02,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 10,
                        width: 50,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}