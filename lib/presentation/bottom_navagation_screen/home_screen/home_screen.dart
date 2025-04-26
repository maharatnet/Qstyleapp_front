import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/children_category_widget.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/female_category_widget.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/men_category_widget.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              HomeHeader(),
              DiscountBanner(),
              // Categories(),
              FemaleCategoryWidget(),
              // SpecialOffers(),
              // SizedBox(height: 20),
              MenCategoryWidget(),
              ChildrenCategoryWidget(),
              // SizedBox(height: 20),
              // PopularProducts(),
              // SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
