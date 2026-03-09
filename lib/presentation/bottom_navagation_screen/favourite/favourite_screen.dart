import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/empty_component.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/not_login_widget.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/category_details_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/favourite/cubit/favourite_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/favourite/product_card.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/favourite/widget/empty_favourite_widget.dart';

// import 'package:shop_app/components/product_card.dart';
// import 'package:shop_app/models/Product.dart';
//
// import '../details/details_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavouriteCubit()..getFavouriteApi(context),
      child: BlocConsumer<FavouriteCubit, FavouriteStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = FavouriteCubit.get(context);
          return SafeArea(
            child: SharedPreferenceGetValue.getToken()==null||SharedPreferenceGetValue.getToken()==""
                ?NotLoggedInWidget(): Column(
              children: [
                Text(
                  tr(TextApp.favourite),
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s18),
                ),
                cubit.is_favourite_data ||
                    state is LoadingGetFavouriteStates
                    ? Expanded(
                      child: GridView.builder(
                                        itemCount: 6,
                                        gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 16,
                                        ),
                                        itemBuilder: (context, index) =>
                        ProductCardShimmer(),
                                      ),
                    )
                    : cubit.favouriteResponseModel == null ||
                    cubit.favouriteResponseModel!.data == null ||
                    cubit.favouriteResponseModel!.data!.length == 0
                    ? Expanded(child: EmptyFavoritesWidget())
                    // ? Expanded(child: EmptyComponent(title: tr(TextApp.no_data)))
                    :  Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                                itemCount: cubit!.favouriteResponseModel!.data!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 0.7,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 16,
                                ),
                                itemBuilder: (context, index) =>
                                    ProductCard(onPress: () {
                                      navigateTo(context, CategoryDetailsScreen(productId: cubit!.favouriteResponseModel!.data![index].id??1,));

                                      // Navigator.pushNamed(
                                  //   context,
                                  //   DetailsScreen.routeName,
                                  //   arguments:
                                  //   ProductDetailsArguments(product: demoProducts[index]),
                                  // )
                                  // ,
                                },favouriteModel: cubit!.favouriteResponseModel!.data![index],),
                              ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
