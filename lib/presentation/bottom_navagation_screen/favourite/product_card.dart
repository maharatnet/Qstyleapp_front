import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/loading_image/image_component.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/home/favourite_response_model.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/favourite/cubit/favourite_cubit.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final FavouriteModel ? favouriteModel;
  ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    this.favouriteModel,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  // final Product product;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit,FavouriteStates>(
        listener: (context,state){},
        builder: (context,state){
          final cubit = FavouriteCubit.get(context);
          return SizedBox(
            width: width,
            child: GestureDetector(
              onTap: onPress,
              child: Container(
                // color: ColorManager.secondColor.withOpacity(.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.12,
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        // padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: kSecondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ImageComponent(path: favouriteModel!.image??"",fit: BoxFit.fill,),
                        // child: Image.asset("assets/images/ps4_console_white_2.png"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                        favouriteModel!.name??"",
                      // TextApp.chairt,
                      overflow: TextOverflow.ellipsis,

                      style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(children: [
                            Text(
                              favouriteModel!.discountPrice!=null&&double.parse(favouriteModel!.discountPrice??"0.0")!>0?
                              "${favouriteModel!.discountPrice??""}"+tr(TextApp.AED):"${favouriteModel!.price??""}"+tr(TextApp.AED),
                              // tr(TextApp.cost120),
                              style: getBoldStyle(color: Colors.black, fontSize: FontSize.s9),
                            ),
                            const SizedBox(width: 4),
                            if (favouriteModel!.discountPrice!=null&&double.parse(favouriteModel!.discountPrice??"0.0")!>0)
                              Text(
                                "${favouriteModel!.price??""}"+tr(TextApp.AED),
                                // tr(TextApp.cost150),
                                style: getRegularLineStyle(color: Colors.red, fontSize: 9),
                              ),


                          ],),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            cubit.addOrRemoveFavourite(context, favouriteModel!.id??1);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color:
                              // ?
                              kPrimaryColor.withOpacity(0.15),
                              // : kSecondaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/Heart Icon_2.svg",
                              color:Color(0xFFFF4848),
                              // ColorFilter.mode(
                                // product.isFavourite
                                //     ?
                                //   const Color(0xFFFF4848),
                                  // : const Color(0xFFDBDEE4),
                                  // BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج الوهمية
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            // عنوان المنتج الوهمي
            Container(
              height: 12,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 4),
            // سعر المنتج الوهمي
            Container(
              height: 12,
              width: 80,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}