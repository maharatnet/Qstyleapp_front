import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/favourite/product_card.dart';
// import 'package:shop_app/components/product_card.dart';
// import 'package:shop_app/models/Product.dart';
//
// import '../details/details_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            "Favorites",
            style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s18),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) => ProductCard(
                
                  onPress: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   DetailsScreen.routeName,
                    //   arguments:
                    //   ProductDetailsArguments(product: demoProducts[index]),
                    // )
                    // ,
                  }
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
