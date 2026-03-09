import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/core/color_for_hex.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navigation_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/children_category_widget.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/female_category_widget.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/men_category_widget.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/screen/brand_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final String phoneNumber = '+8615024551117'; // رقم الهاتف مع كود الدولة
  Future<void> openWhatsApp() async {
    final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("لا يمكن فتح واتساب على هذا الجهاز");
    }
  }
  Future<void> openApp(String url) async {
    final Uri whatsappUrl = Uri.parse(url);

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("لا يمكن فتح واتساب على هذا الجهاز");
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavigationCubit, BottomNavigationStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BottomNavigationCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  HomeHeader(),
                  // Text("${SharedPreferenceGetValue.getLanguage()}"),
                  cubit.is_banner_data
                      ? DiscountBannerShimmer()
                      : DiscountBanner(banner: cubit!.bannerResponseModel!.data,onClick: (data){
                        print(data);
                        if(data!=null&&data.isNotEmpty){
                          openApp(data);
                        }
                  },),
                  // Categories(),
                  if(cubit.is_category_data)
                  CustomCategoryShimmerWidget(),
                  if(!cubit.is_category_data&&cubit.categoryResponseModel!=null)
                    for(int i=0;i<cubit.categoryList!.length;i++)...{
                      CustomCategoryWidget(
                        categoryModel: cubit.categoryList![i],
                        is_home: true,

                      ),
                    }
                  ,
                  SizedBox(height: 10,),
                  if(!cubit.is_category_data&&cubit.categoryResponseModel!=null)
                    CategoryOfferCardImageAsset(
                      press: () {
                        openWhatsApp();
                        // navigateTo(context, BrandScreen());
                        // Navigator.pushNamed(context, ProductsScreen.routeName);
                      }, color: cubit.appSettingsResponse==null?Colors.black:getColorFromHex(cubit.appSettingsResponse!.data!.luxury_color??""),
                    ),
                  // SpecialOffers(),
                  // SizedBox(height: 20),
                  // MenCategoryWidget(),
                  // ChildrenCategoryWidget(),
                  // SizedBox(height: 20),
                  // PopularProducts(),
                  // SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
