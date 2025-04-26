import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/category_item_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/female_category_widget.dart';

import 'section_title.dart';

class ChildrenCategoryWidget extends StatelessWidget {
  const ChildrenCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: SectionTitle(
        //     title: "Children Category",
        //     press: () {},
        //   ),
        // ),
        CategoryOfferCard(
          image: "assets/images/Image Banner 3.png",
          category: "Children Category",
          numOfBrands: 8,
          press: () {
            // Navigator.pushNamed(context, ProductsScreen.routeName);
          },
        ),
        SizedBox(height: 10,),
        Wrap(children: dataList.map((e)=> Padding(padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: (){
              navigateTo(context, CategoryItemScreen());
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width*.24,
              child: Column(children: [
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
                SizedBox(height: 4,),
                Text(e.name??"",style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16),),

              ],),
            ),
          ),

        )).toList(),)


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