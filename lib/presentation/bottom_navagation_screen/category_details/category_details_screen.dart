import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/custom_button.dart';
import 'package:maharat_ecommerce/component/empty_component.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/not_login/card_not_login.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/home/show_products_response_model.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/components/build_product_shimmer.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/components/color_dots.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/components/product_description.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/components/product_images.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/components/top_rounded_container.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/cubit/category_details_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/size_option.dart';

// class CategoryDetailsScreen extends StatelessWidget {
//   final int productId;
//
//   CategoryDetailsScreen({super.key, required this.productId});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) =>
//           CategoryDetailsCubit()..getCategoryProductApi(context, productId),
//       child: BlocConsumer<CategoryDetailsCubit, CategoryDetailsStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           final cubit = CategoryDetailsCubit.get(context);
//           return Scaffold(
//             extendBody: true,
//             extendBodyBehindAppBar: true,
//             backgroundColor: const Color(0xFFF5F6F9),
//
//             body: cubit.is_category_data
//                 ? buildProductShimmer()
//                 : cubit.showProductModel == null ||
//                         cubit.showProductModel!.data == null
//                     ? EmptyComponent(title: tr(TextApp.no_data))
//                     : ListView(
//                         children: [
//                           ProductImages(
//                             imageList: cubit
//                                     .showProductModel!.data!.images!.isEmpty
//                                 ? [
//                                     ImagesModel(
//                                         image: cubit.showProductModel!.data!
//                                                 .image ??
//                                             "",
//                                         id: 1)
//                                   ]
//                                 : cubit.showProductModel!.data!.images ?? [],
//                           ),
//                           // ProductImages(product: product),
//                           TopRoundedContainer(
//                             color: Colors.white,
//                             child: Column(
//                               children: [
//                                 ProductDescription(
//                                   // product: product,
//                                   pressOnSeeMore: () {},
//                                 ),
//                                 TopRoundedContainer(
//                                   color: const Color(0xFFF6F7F9),
//                                   child: Column(
//                                     children: [
//                                       ColorDots(
//                                         colors: cubit.showProductModel!.data!
//                                                 .colors ??
//                                             [],
//                                       ),
//                                       SizedBox(
//                                         height: 2,
//                                       ),
//                                       Row(
//                                         children: [
//                                           SizedBox(
//                                             width: 12,
//                                           ),
//                                           Text(
//                                             tr(TextApp.selectSize),
//                                             style: getBoldStyle(
//                                                 color: Colors.black,
//                                                 fontSize: FontSize.s16),
//                                           ),
//                                           SizedBox(
//                                             width: 12,
//                                           ),
//                                         ],
//                                       ),
//                                       SizeOptions(
//                                         sizes: cubit.showProductModel!.data!
//                                                 .sizes ??
//                                             [],
//                                         // ["S", "M", "L", "XL", "XXL"],
//                                         selectedSize: cubit.sizeSelect,
//                                         onSizeSelected: (size) {
//                                           // setState(() {
//                                           cubit.sizeSelect = size;
//                                           cubit.refreshData();
//                                           // });
//                                         },
//                                       ),
//                                       // ColorDots(product: product),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           if (cubit.showProductModel!.data!.category!
//                                       .subcategories !=
//                                   null &&
//                               cubit.showProductModel!.data!.category!
//                                       .subcategories!.length >
//                                   0)
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 tr(TextApp.related),
//                                 style: getBoldStyle(
//                                     color: Colors.black,
//                                     fontSize: FontSize.s18),
//                               ),
//                             ),
//                           if (cubit.showProductModel!.data!.category!
//                                       .subcategories !=
//                                   null &&
//                               cubit.showProductModel!.data!.category!
//                                       .subcategories!.length >
//                                   0)
//                             SizedBox(
//                               height: 14,
//                             ),
//                           if (cubit.showProductModel!.data!.category!
//                                       .subcategories !=
//                                   null &&
//                               cubit.showProductModel!.data!.category!
//                                       .subcategories!.length >
//                                   0)
//                             Container(
//                               height: 220,
//                               width: MediaQuery.sizeOf(context).width,
//                               child: ListView.builder(
//                                 itemCount: cubit.showProductModel!.data!
//                                     .category!.subcategories!.length,
//                                 scrollDirection: Axis.horizontal,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 8),
//                                 // مسافة بين العناصر
//                                 itemBuilder: (context, index) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       // Action لما المستخدم يضغط
//                                     },
//                                     child: Container(
//                                       margin: const EdgeInsets.symmetric(
//                                           horizontal: 8),
//                                       // المسافة بين العناصر
//                                       width: 180,
//                                       // العرض ثابت لكل عنصر
//                                       // padding: EdgeInsets.all(4),
//                                       decoration: BoxDecoration(
//                                         color: ColorManager.white,
//                                         borderRadius: BorderRadius.circular(
//                                             12), // حواف دائرية
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         // لتوجيه النصوص من اليسار لليمين
//                                         children: [
//                                           AspectRatio(
//                                             aspectRatio: 1.25, // نسبة الأبعاد
//                                             child: Container(
//                                               padding: const EdgeInsets.all(16),
//                                               child: Image.asset(
//                                                 index == 0
//                                                     ? "assets/images/ps4_console_white_1.png"
//                                                     : index == 1
//                                                         ? "assets/images/ps4_console_white_2.png"
//                                                         : index == 2
//                                                             ? "assets/images/ps4_console_white_3.png"
//                                                             : "assets/images/ps4_console_white_4.png",
//                                                 fit: BoxFit.contain,
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               width: double.infinity,
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 8,
//                                                       vertical: 4),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.vertical(
//                                                   bottom: Radius.circular(
//                                                       12), // الحواف السفلية دائرية
//                                                 ),
//                                               ),
//                                               child: Column(
//                                                 // crossAxisAlignment: CrossAxisAlignment.start,  // النصوص تبدأ من اليسار
//                                                 children: [
//                                                   Text(
//                                                     tr(TextApp.chairt),
//                                                     style: getBoldStyle(
//                                                         color: Colors.black,
//                                                         fontSize: FontSize.s16),
//                                                     maxLines: 1,
//                                                     overflow: TextOverflow
//                                                         .ellipsis, // لو العنوان طويل يتقص
//                                                   ),
//                                                   const SizedBox(height: 2),
//                                                   Text(
//                                                     tr(TextApp.cost150),
//                                                     style: TextStyle(
//                                                         color: Colors.red,
//                                                         fontSize: 12),
//                                                   ),
//                                                   const SizedBox(height: 2),
//                                                   Text(
//                                                     tr(TextApp.cost120),
//                                                     style: getBoldStyle(
//                                                         color: Colors.black,
//                                                         fontSize: FontSize.s14),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//
//           if(SharedPreferenceGetValue.getToken() == null ||
//                               SharedPreferenceGetValue.getToken() == "")Container(
//                               height: 140,
//                               child: CardNotLoginScreen())
//                         ],
//                       ),
//             bottomNavigationBar:SharedPreferenceGetValue.getToken() == null ||
//                 SharedPreferenceGetValue.getToken() == ""?Text(""): cubit.showProductModel == null ||
//                     cubit.showProductModel!.data == null
//                 ? Text("")
//                 : TopRoundedContainer(
//                     color: Colors.white,
//                     child: SafeArea(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 12),
//                         child: CustomButton(
//                             isBuy: state is LoadingAddCartDataStates,
//                             onTap: () {
//                               Map<String, dynamic> dummyData = {
//                                 "product_id": productId,
//                                 "quantity": cubit.quantity,
//                               };
//                               if (cubit.sizeSelect != null)
//                                 dummyData["size_id"] =
//                                     cubit.sizeSelect!.id ?? 1;
//                               if (cubit.colorModel != null)
//                                 dummyData["color_id"] =
//                                     cubit.colorModel!.id ?? 1;
//                               cubit.addCart(context, dummyData);
//                               // navigateAndFinish(context, BottomNavigationScreen(startIndex: 2,));
//                             },
//                             backgroundColor: ColorManager.secondColor,
//                             textColor: ColorManager.white,
//                             buttonText: tr(TextApp.addCart)),
//
//                         // ElevatedButton(
//                         //   onPressed: () {
//                         //     // Navigator.pushNamed(context, CartScreen.routeName);
//                         //   },
//                         //   child: const Text("Add To Cart"),
//                         // ),
//                       ),
//                     ),
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }
class CategoryDetailsScreen extends StatelessWidget {
  final int productId;

  CategoryDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      CategoryDetailsCubit()..getCategoryProductApi(context, productId),
      child: BlocConsumer<CategoryDetailsCubit, CategoryDetailsStates>(
        listener: (context, state) {
          // استمع لحالة فحص التوفر
          if (state is ProductAvailabilityCheckedState) {
            if (!state.isAvailable&&CategoryDetailsCubit.get(context).show_product!=0) {
              _showProductUnavailableDialog(context);
            }
          }
        },
        builder: (context, state) {
          final cubit = CategoryDetailsCubit.get(context);
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: const Color(0xFFF5F6F9),

            body: cubit.is_category_data
                ? buildProductShimmer()
                : cubit.showProductModel == null ||
                cubit.showProductModel!.data == null
                ? EmptyComponent(title: tr(TextApp.no_data))
                : ListView(
              children: [
                ProductImages(
                  imageList: cubit
                      .showProductModel!.data!.images!.isEmpty
                      ? [
                    ImagesModel(
                        image: cubit.showProductModel!.data!
                            .image ??
                            "",
                        id: 1)
                  ]
                      : cubit.showProductModel!.data!.images ?? [],
                ),
                // ProductImages(product: product),
                TopRoundedContainer(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ProductDescription(
                        // product: product,
                        pressOnSeeMore: () {},
                      ),
                      TopRoundedContainer(
                        color: const Color(0xFFF6F7F9),
                        child: Column(
                          children: [
                            ColorDots(
                              colors: cubit.showProductModel!.data!
                                  .colors ??
                                  [],
                              ontap: (){
                                cubit.show_product =1;
                                cubit.refreshData();
                                _checkProductAvailability(cubit, context);
                              },
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                if( cubit.showProductModel!=null&&cubit.showProductModel!.data!=null&&cubit.showProductModel!.data!.sizes!.isNotEmpty)
                                Text(
                                  tr(TextApp.selectSize),
                                  style: getBoldStyle(
                                      color: Colors.black,
                                      fontSize: FontSize.s16),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                              ],
                            ),
                            SizeOptions(
                              sizes: cubit.showProductModel!.data!.sizes ??
                                  [],
                              // ["S", "M", "L", "XL", "XXL"],
                              selectedSize: cubit.sizeSelect,
                              onSizeSelected: (size) {
                                cubit.show_product =1;
                                cubit.sizeSelect = size;
                                cubit.refreshData();
                                // فحص التوفر عند تغيير الحجم
                                _checkProductAvailability(cubit, context);
                              },
                            ),

                            // عرض حالة التوفر
                            _buildAvailabilityStatus(cubit, state),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (cubit.showProductModel!.data!.category!
                    .subcategories !=
                    null &&
                    cubit.showProductModel!.data!.category!
                        .subcategories!.length >
                        0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tr(TextApp.related),
                      style: getBoldStyle(
                          color: Colors.black,
                          fontSize: FontSize.s18),
                    ),
                  ),
                if (cubit.showProductModel!.data!.category!
                    .subcategories !=
                    null &&
                    cubit.showProductModel!.data!.category!
                        .subcategories!.length >
                        0)
                  SizedBox(
                    height: 14,
                  ),
                if (cubit.showProductModel!.data!.category!
                    .subcategories !=
                    null &&
                    cubit.showProductModel!.data!.category!
                        .subcategories!.length >
                        0)
                  Container(
                    height: 220,
                    width: MediaQuery.sizeOf(context).width,
                    child: ListView.builder(
                      itemCount: cubit.showProductModel!.data!
                          .category!.subcategories!.length,
                      scrollDirection: Axis.horizontal,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Action لما المستخدم يضغط
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8),
                            width: 180,
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.25,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Image.asset(
                                      index == 0
                                          ? "assets/images/ps4_console_white_1.png"
                                          : index == 1
                                          ? "assets/images/ps4_console_white_2.png"
                                          : index == 2
                                          ? "assets/images/ps4_console_white_3.png"
                                          : "assets/images/ps4_console_white_4.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.vertical(
                                        bottom: Radius.circular(12),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          tr(TextApp.chairt),
                                          style: getBoldStyle(
                                              color: Colors.black,
                                              fontSize: FontSize.s16),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          tr(TextApp.cost150),
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          tr(TextApp.cost120),
                                          style: getBoldStyle(
                                              color: Colors.black,
                                              fontSize: FontSize.s14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                if(SharedPreferenceGetValue.getToken() == null ||
                    SharedPreferenceGetValue.getToken() == "")Container(
                    height: 140,
                    child: CardNotLoginScreen())
              ],
            ),
            bottomNavigationBar:SharedPreferenceGetValue.getToken() == null ||
                SharedPreferenceGetValue.getToken() == ""?Text(""): cubit.showProductModel == null ||
                cubit.showProductModel!.data == null
                ? Text("")
                : TopRoundedContainer(
              color: Colors.white,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  child: CustomButton(
                      isBuy: state is LoadingAddCartDataStates || state is LoadingProductAvailabilityState,
                      onTap: cubit.isProductAvailable ? () {
                        Map<String, dynamic> dummyData = {
                          "product_id": productId,
                          "quantity": cubit.quantity,
                        };
                        if (cubit.sizeSelect != null)
                          dummyData["size_id"] =
                              cubit.sizeSelect!.id ?? 1;
                        if (cubit.colorModel != null)
                          dummyData["color_id"] =
                              cubit.colorModel!.id ?? 1;
                        cubit.addCart(context, dummyData);
                      } : null, // تعطيل الزر إذا غير متوفر
                      backgroundColor: cubit.isProductAvailable
                          ? ColorManager.secondColor
                          : Colors.grey,
                      textColor: ColorManager.white,
                      buttonText: cubit.isProductAvailable
                          ? tr(TextApp.addCart)
                          : tr(TextApp.outOfStock)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // فحص توفر المنتج
  void _checkProductAvailability(CategoryDetailsCubit cubit, BuildContext context) {
    if (cubit.sizeSelect != null || cubit.colorModel != null) {
      Map<String, dynamic> checkData = {
        "product_id": productId,
        "quantity": cubit.quantity,
      };

      if (cubit.sizeSelect != null) {
        checkData["size_id"] = cubit.sizeSelect!.id ?? 1;
      }

      if (cubit.colorModel != null) {
        checkData["color_id"] = cubit.colorModel!.id ?? 1;
      }

      cubit.checkProduct(context, checkData);
    }
  }

  // عرض حالة التوفر
  Widget _buildAvailabilityStatus(CategoryDetailsCubit cubit, CategoryDetailsStates state) {
    if (state is LoadingProductAvailabilityState) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            SizedBox(width: 12),
            Text(
              tr(TextApp.checkingAvailability),
              style: getRegularStyle(color: Colors.blue, fontSize: FontSize.s14),
            ),
          ],
        ),
      );
    }

    if (cubit.sizeSelect != null || cubit.colorModel != null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cubit.isProductAvailable ? Colors.green.shade50 : Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: cubit.isProductAvailable ? Colors.green.shade200 : Colors.red.shade200,
          ),
        ),
        child: Row(
          children: [
            Icon(
              cubit.isProductAvailable ? Icons.check_circle : Icons.cancel,
              color: cubit.isProductAvailable ? Colors.green : Colors.red,
              size: 20,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                cubit.isProductAvailable
                    ? tr(TextApp.productAvailable)
                    : tr(TextApp.productNotAvailable),
                style: getRegularStyle(
                  color: cubit.isProductAvailable ? Colors.green : Colors.red,
                  fontSize: FontSize.s14,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox.shrink();
  }

  // عرض dialog للمنتج غير المتوفر
  void _showProductUnavailableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.orange, size: 28),
            SizedBox(width: 12),
            Text(
              tr(TextApp.productNotAvailable),
              style: getBoldStyle(color: Colors.black, fontSize: FontSize.s18),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(TextApp.productNotAvailableDescription),
              style: getRegularStyle(color: Colors.grey.shade600, fontSize: FontSize.s14),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.blue, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tr(TextApp.tryDifferentOptions),
                      style: getRegularStyle(color: Colors.blue, fontSize: FontSize.s12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              tr(TextApp.ok),
              style: getBoldStyle(color: ColorManager.secondColor, fontSize: FontSize.s14),
            ),
          ),
        ],
      ),
    );
  }
}
