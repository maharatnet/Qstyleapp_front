import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/category_item_screen.dart';

import 'section_title.dart';

class FemaleCategoryWidget extends StatelessWidget {
  const FemaleCategoryWidget({
    Key? key,
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
          image: "assets/images/Image Banner 2.png",
          category: "Female Category",
          numOfBrands: 18,
          press: () {
            // Navigator.pushNamed(context, ProductsScreen.routeName);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
          children: dataList
              .map((e) => Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        navigateTo(context, CategoryItemScreen());
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * .24,
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1.02,
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: kSecondaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset(e.image),
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
        )

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
    name: "ملابس",
    image: "assets/images/ps4_console_white_1.png",
  ),
  CategoryHomeModel(
    name: "احذية",
    image: "assets/images/ps4_console_white_2.png",
  ),
  CategoryHomeModel(
    name: "ساعات",
    image: "assets/images/ps4_console_white_3.png",
  ),
  CategoryHomeModel(
    name: "برفانات",
    image: "assets/images/ps4_console_white_4.png",
  ),
  CategoryHomeModel(
    name: "ملابس",
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
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
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
                            text: "$numOfBrands Brands",
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

class CategoryHomeModel {
  String name;
  String image;

  CategoryHomeModel({required this.name, required this.image});
}
