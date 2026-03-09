import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/empty_component.dart';
import 'package:maharat_ecommerce/component/enums.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/loading_image/image_component.dart';
import 'package:maharat_ecommerce/component/loading_image/photo_screen.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/home/category_response_model.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/category_details_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/category_item_shimmer_widget.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/cubit/category_item_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/home_screen/components/search_field.dart';

// class CategoryItemScreen extends StatelessWidget {
//  final int categoryId;
//   final List<BrandModel> brandList  ;
//    CategoryItemScreen({Key? key, required this.categoryId,required this.brandList = []}) : super(key: key);
//
//   // List<CategoryHomeModel> filteredList = dataListItems;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(create: (_)=>CategoryItemCubit()..getCategoryApi(context, categoryId),
//     child: BlocConsumer<CategoryItemCubit,CategoryItemStates>(
//         listener: (context,state){},
//        builder: (context,state){
//           final cubit = CategoryItemCubit.get(context);
//           return Scaffold(
//             appBar: AppBar(title: Text(tr(TextApp.category_Items),style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s18),)),
//             body: Column(
//               children: [
//                 // سيرش بار
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                   child:SearchField(onChanged: (query) => cubit.updateFilters(query,)),
//                 ),
//                 const SizedBox(height: 10),
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                   child: Wrap(
//                     children: [
//                       filterChip(tr(TextApp.highPrice), 'Highest Price',cubit),
//                       filterChip(tr(TextApp.lowPrice), 'Lowest Price',cubit),
//                       filterChip(tr(TextApp.discount), 'Discounted',cubit),
//                       filterChip(tr(TextApp.brand), 'brand',cubit),
//
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child:cubit.is_category_data?
//          CategoryGridShimmerWidget():
//                       cubit.categoryProductModel==null||
//                   cubit.categoryProductModel!.data==null?
//                           Text("")
//                           :cubit.categoryProductModel!.data!.length==0?
//                           EmptyComponent(title: tr(TextApp.no_data))
//                           :
//                   GridView.builder(
//                     padding: const EdgeInsets.all(8.0),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, // 2 عناصر في الصف الواحد
//                       crossAxisSpacing: 10, // المسافة بين الأعمدة
//                       mainAxisSpacing: 10, // المسافة بين الصفوف
//                       childAspectRatio: 0.8, // عرض العنصر بنسبة معينة
//                       // childAspectRatio: 0.75, // عرض العنصر بنسبة معينة
//                     ),
//                     itemCount: cubit.filteredList.length,
//                     itemBuilder: (context, index) {
//                       final e = cubit.filteredList[index];
//                       return GestureDetector(
//                         onTap: () {
//                           navigateTo(context, CategoryDetailsScreen(productId: e.id??1,));
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: kSecondaryColor.withOpacity(0.1),
//                             // color: kSecondaryColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             children: [
//                               AspectRatio(
//                                 aspectRatio: 1.25,
//                                 // aspectRatio: 1.25,
//                                 child:Stack(
//                                   children: [
//                                     Container(
//                                       // padding: const EdgeInsets.all(20),
//                                       child: ClipRRect(
//                                         borderRadius:BorderRadius.only(topLeft:Radius.circular(12),topRight: Radius.circular(12)),
//                                         child: ImageComponent(path: e.image??"",
//                                         fit: BoxFit.fill,
//                                         width: MediaQuery.sizeOf(context).width,
//                                         height: MediaQuery.sizeOf(context).height,
//                                         ),
//                                       ),
//                                       // child: Image.asset(e.image??""),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.topRight,
//                                       child: IconButton(onPressed: (){
//                                         navigateTo(context,PhotoScreen(image:e.image??"" ,imageFrom: ImageFrom.network,));
//
//                                       }, icon: Icon(Icons.remove_red_eye,color: ColorManager.primary,)),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Expanded(child:Container(
//                                 color: Colors.white,
//                                 width: MediaQuery.sizeOf(context).width,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 3,right: 3),
//                                   child: Column(
//
//                                     children: [
//                                       Text(
//                                         e.name??"",
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: getBoldStyle(color: Colors.black, fontSize: FontSize.s16),
//                                       ),
//
//
//                                         Row(
//                                           children: [
//                                             if (e.discountPrice!=null&&e.discountPrice!>0)
//                                               Expanded(
//                                                 child: Text(
//                                                   "${e.price}"+tr(TextApp.AED),
//                                                   // TextApp.cost150,
//                                                   // 'خصم ${e.discount}%',
//                                                   style: getRegularLineStyle(color:
//                                                       Colors.black,
//                                                   // Colors.red,
//                                                       fontSize: FontSize.s10),
//                                                 ),
//                                               ),
//                                             SizedBox(width: 2,),
//                                             Expanded(
//                                               child: Text(
//                                                   e.discountPrice!=null&&e.discountPrice!>0?
//                                                   '${e.discountPrice} '+tr(TextApp.AED):'${e.price} '
//
//                                                       +tr(TextApp.AED),
//                                                 overflow: TextOverflow.ellipsis,
//                                               style: getBoldStyle(color:e.discountPrice!=null&&e.discountPrice!>0?Colors.red: Colors.black, fontSize: FontSize.s12),
//                                                                                   ),
//                                             ),
//                                           ],
//                                         ),
//                                     ],),
//                                 ),))
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//        },
//     ),
//     );
//   }
//
//   // دالة لعرض الفلاتر بشكل دائري
//   Widget filterChip(String label, String value,cubit) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
//       child: FilterChip(
//         label: Text(label),
//         selected: cubit.selectedFilters.contains(value),
//         onSelected: (bool selected) {
//           // setState(() {
//             if (selected) {
//               cubit.selectedFilters.add(value);
//             } else {
//               cubit.selectedFilters.remove(value);
//             }
//             cubit.refreshData();
//           // });
//           cubit.updateFilters(cubit.searchQuery);
//         },
//         selectedColor: ColorManager.primary, // لون الخلفية عند التحديد
//         labelStyle: getBoldStyle(
//           fontSize: 10,
//           color: cubit.selectedFilters.contains(value) ? Colors.white : Colors.black,
//         ),
//         backgroundColor: Colors.grey.shade200, // لون الخلفية عند عدم التحديد
//         // backgroundColor: Colors.grey.shade200, // لون الخلفية عند عدم التحديد
//         shape: StadiumBorder(),
//       ),
//     );
//   }
// }
//

class CategoryItemScreen extends StatelessWidget {
  final int categoryId;
  final int is_international;
  final List<BrandModel> brandList;

  CategoryItemScreen({Key? key, required this.categoryId,required this.is_international, this.brandList = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryItemCubit()..getCategoryApi(context, categoryId,is_international),
      child: BlocConsumer<CategoryItemCubit, CategoryItemStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = CategoryItemCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                tr(TextApp.category_Items),
                style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18),
              ),
            ),
            body: Column(
              children: [
                // سيرش بار
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SearchField(onChanged: (query) => cubit.updateFilters(query)),
                ),

                // الفلاتر - تصميم محسن
                Container(
                  height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        // Brand Dropdown أولاً
                        if (brandList.isNotEmpty) ...[
                          _buildBrandDropdown(cubit, context),
                          SizedBox(width: 8),
                        ],
                        // باقي الفلاتر
                        filterChip(tr(TextApp.highPrice), 'Highest Price', cubit),
                        filterChip(tr(TextApp.lowPrice), 'Lowest Price', cubit),
                        filterChip(tr(TextApp.discount), 'Discounted', cubit),
                        // filterChip(tr(TextApp.international), 'international', cubit),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Grid View مع حالات مختلفة
                Expanded(
                  child: cubit.is_category_data
                      ? CategoryGridShimmerWidget()
                      : cubit.categoryProductModel == null || cubit.categoryProductModel!.data == null
                      ? _buildEmptyState(context, "حدث خطأ في تحميل البيانات")
                      : cubit.categoryProductModel!.data!.length == 0
                      ? _buildEmptyState(context, tr(TextApp.no_data))
                      : cubit.filteredList.isEmpty
                      ? _buildNoResultsState(context)
                      : GridView.builder(
                    padding: const EdgeInsets.all(12.0),
                    // padding: const EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      // crossAxisSpacing: 12,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: cubit.filteredList.length,
                    itemBuilder: (context, index) {
                      final e = cubit.filteredList[index];
                      return _buildProductCard(context, e);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Product Card Widget
  Widget _buildProductCard(BuildContext context, dynamic e) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, CategoryDetailsScreen(productId: e.id ?? 1));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: ImageComponent(
                        path: e.image ?? "",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  // أيقونة الخصم
                  if (e.discountPrice != null && double.parse(e.discountPrice??"0.0")! > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "خصم",
                          style: getBoldStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  // أيقونة العرض
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        navigateTo(
                          context,
                          PhotoScreen(
                            image: e.image ?? "",
                            imageFrom: ImageFrom.network,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.remove_red_eye,
                          color: ColorManager.primary,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // تفاصيل المنتج
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0,bottom: 8,right: 2,left: 2),
                // padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // اسم المنتج
                    Text(
                      e.name ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: getBoldStyle(color: Colors.black, fontSize: FontSize.s14),
                    ),

                    // السعر
                    Row(
                      children: [
                        if (e.discountPrice != null && double.parse(e.discountPrice??"0.0")! > 0) ...[
                          // السعر القديم
                          Expanded(
                            child: Text(
                              "${e.price} " + tr(TextApp.AED),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: FontSize.s10,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          // السعر الجديد
                          Expanded(
                            child: Text(
                              "${e.discountPrice} " + tr(TextApp.AED),
                              style: getBoldStyle(color: Colors.red, fontSize: FontSize.s12),
                            ),
                          ),
                        ] else ...[
                          // السعر العادي
                          Text(
                            "${e.price} " + tr(TextApp.AED),
                            style: getBoldStyle(color: Colors.black, fontSize: FontSize.s14),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Brand Dropdown Widget محسن
  Widget _buildBrandDropdown(cubit, BuildContext context) {
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: cubit.selectedBrandId != null ? ColorManager.primary : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: cubit.selectedBrandId != null ? ColorManager.primary : Colors.grey.shade300,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int?>(
          value: cubit.selectedBrandId,
          hint: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.business,
                size: 14,
                color: cubit.selectedBrandId != null ? Colors.white : Colors.grey.shade600,
              ),
              SizedBox(width: 6),
              Text(
                tr(TextApp.brand),
                style: getBoldStyle(
                  fontSize: 12,
                  color: cubit.selectedBrandId != null ? Colors.white : Colors.grey.shade700,
                ),
              ),
            ],
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: cubit.selectedBrandId != null ? Colors.white : Colors.grey.shade600,
            size: 18,
          ),
          dropdownColor: Colors.white,
          items: [
        // العنصر الافتراضي: جميع البراندات
        DropdownMenuItem<int?>(
        value: null,
          child: Row(
            children: [
              Icon(Icons.clear_all, size: 16, color: Colors.grey.shade600),
              SizedBox(width: 8),
              Text(
                "جميع البراندات",
                style: getRegularStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ),

          // عناصر البراندز بعد الفلترة
          ...(
          cubit.selectedFilters.contains('international')
          ? brandList.where((brand) => brand.isInterantional == 1)
          : brandList  //.where((brand)=>brand.isInterantional==0)
    ).map((brand) {
      return DropdownMenuItem<int?>(
        value: brand.id,
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.primary.withOpacity(0.1),
              ),
              child: Icon(
                Icons.business,
                size: 12,
                color: ColorManager.primary,
              ),
            ),
            SizedBox(width: 8),
            Text(
              brand.name ?? "",
              style: getRegularStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      );
    }).toList(),
    ],

    // [
          //   DropdownMenuItem<int?>(
          //     value: null,
          //     child: Row(
          //       children: [
          //         Icon(Icons.clear_all, size: 16, color: Colors.grey.shade600),
          //         SizedBox(width: 8),
          //         Text(
          //           "جميع البراندات",
          //           style: getRegularStyle(fontSize: 12, color: Colors.black),
          //         ),
          //       ],
          //     ),
          //   ),
          //   // selectedFilters.contains('international')
          //   ...brandList.map((brand) {
          //
          //     return DropdownMenuItem<int?>(
          //       value: brand.id,
          //       child: Row(
          //         children: [
          //           Container(
          //             width: 20,
          //             height: 20,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: ColorManager.primary.withOpacity(0.1),
          //             ),
          //             child: Icon(
          //               Icons.business,
          //               size: 12,
          //               color: ColorManager.primary,
          //             ),
          //           ),
          //           SizedBox(width: 8),
          //           Text(
          //             brand.name ?? "",
          //             style: getRegularStyle(fontSize: 12, color: Colors.black),
          //           ),
          //         ],
          //       ),
          //     );
          //   }).toList(),
          // ],
          onChanged: (int? newValue) {
            cubit.updateBrandFilter(newValue);
          },
        ),
      ),
    );
  }

  // Filter Chip محسن
  Widget filterChip(String label, String value, cubit) {
    bool isSelected = cubit.selectedFilters.contains(value);

    return Container(
      margin: EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getFilterIcon(value, isSelected),
            SizedBox(width: 4),
            Text(label),
          ],
        ),
        selected: isSelected,
        onSelected: (bool selected) {
          if (selected) {
            cubit.selectedFilters.add(value);
          } else {
            cubit.selectedFilters.remove(value);
          }
          cubit.refreshData();
          cubit.updateFilters(cubit.searchQuery);
        },
        selectedColor: ColorManager.primary,
        checkmarkColor: Colors.white,
        labelStyle: getBoldStyle(
          fontSize: 11,
          color: isSelected ? Colors.white : Colors.grey.shade700,
        ),
        backgroundColor: Colors.white,
        shape: StadiumBorder(
          side: BorderSide(
            color: isSelected ? ColorManager.primary : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        elevation: isSelected ? 2 : 0,
        pressElevation: 4,
      ),
    );
  }

  // أيقونات الفلاتر
  Widget _getFilterIcon(String value, bool isSelected) {
    IconData iconData;
    switch (value) {
      case 'Highest Price':
        iconData = Icons.trending_up;
        break;
      case 'Lowest Price':
        iconData = Icons.trending_down;
        break;
      case 'Discounted':
        iconData = Icons.local_offer;
        case 'international':
        iconData = Icons.g_mobiledata;
        break;
      default:
        iconData = Icons.filter_alt;
    }

    return Icon(
      iconData,
      size: 14,
      color: isSelected ? Colors.white : Colors.grey.shade600,
    );
  }

  // Empty State Widget
  Widget _buildEmptyState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),
          ),
          SizedBox(height: 24),
          Text(
            message,
            style: getBoldStyle(
              color: Colors.grey.shade600,
              fontSize: FontSize.s16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            "لا توجد منتجات متاحة حالياً",
            style: getRegularStyle(
              color: Colors.grey.shade500,
              fontSize: FontSize.s14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // No Results State Widget
  Widget _buildNoResultsState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off,
              size: 60,
              color: ColorManager.primary,
            ),
          ),
          SizedBox(height: 24),
          Text(
            "لم يتم العثور على نتائج",
            style: getBoldStyle(
              color: Colors.grey.shade700,
              fontSize: FontSize.s18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            "جرب تغيير كلمات البحث أو الفلاتر",
            style: getRegularStyle(
              color: Colors.grey.shade500,
              fontSize: FontSize.s14,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // إعادة تعيين الفلاتر
              final cubit = BlocProvider.of<CategoryItemCubit>(context);
              cubit.selectedFilters.clear();
              cubit.selectedBrandId = null;
              cubit.updateFilters("");
            },
            icon: Icon(Icons.refresh, size: 18),
            label: Text("إعادة تعيين الفلاتر"),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}