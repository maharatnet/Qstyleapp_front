import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/html_to_rich_text.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/cubit/category_details_cubit.dart';



class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    this.pressOnSeeMore,
  }) : super(key: key);

  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<CategoryDetailsCubit,CategoryDetailsStates>(
       listener: (context,state){},
      builder: (context,state){
         final cubit  = CategoryDetailsCubit.get(context);
         return Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: Text(
                 cubit.showProductModel!.data!.name??"",
                 // tr(TextApp.chairt),
                 style: Theme.of(context).textTheme.titleLarge,
               ),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: Row(children: [
                 if (cubit.showProductModel!.data!.discountPrice!=null&&double.parse(cubit.showProductModel!.data!.discountPrice??"0.0")!>0)
                   Text(
                     "${cubit.showProductModel!.data!.price??""}"+tr(TextApp.AED),
                     // tr(TextApp.cost150),
                     style: getRegularLineStyle(color:
                     Colors.black,
                         // Colors.red,
                         fontSize: 14),
                   ),
                 const SizedBox(width: 20),
                 Text(
               cubit.showProductModel!.data!.discountPrice!=null&&double.parse(cubit.showProductModel!.data!.discountPrice??"0.0")!>0?
               "${cubit.showProductModel!.data!.discountPrice??""}"+tr(TextApp.AED):"${cubit.showProductModel!.data!.price??""}"+tr(TextApp.AED),
                   // tr(TextApp.cost120),
                   style: getBoldStyle(color:cubit.showProductModel!.data!.discountPrice!=null&&double.parse(cubit.showProductModel!.data!.discountPrice??"0.0")!>0?
                   Colors.red
                   :Colors.black, fontSize: FontSize.s20),
                 ),




               ],),
             ),
             if (SharedPreferenceGetValue.getToken() != null &&
                 SharedPreferenceGetValue.getToken() != "")
             Align(
               alignment: Alignment.centerRight,
               child: GestureDetector(
                 onTap: (){
                   cubit.addOrRemoveFavourite(context, cubit.showProductModel!.data!.id??0);
                 },
                 child: Container(
                   padding: const EdgeInsets.all(16),
                   width: 48,
                   decoration: BoxDecoration(
                     color: //product.isFavourite
                     // ?
                   cubit.showProductModel!.data!.added_to_favouries==1?
                     const Color(0xFFFFE6E6):
                      const Color(0xFFF5F6F9),
                     borderRadius: const BorderRadius.only(
                       topLeft: Radius.circular(20),
                       bottomLeft: Radius.circular(20),
                     ),
                   ),
                   child:state is LoadingAddFavouriteDataStates?
                   Center(
                     child: SizedBox(
                       width: 15, // العرض المطلوب
                       height: 15, // الارتفاع المطلوب
                       child: CircularProgressIndicator(
                         // value: 0.3, // القيمة بين 0 و 1 (مش 3)
                         // strokeWidth: 3, // ممكن تتحكم في سمك الخط هنا
                       ),
                     ),
                   )
            : SvgPicture.asset(
                     "assets/icons/Heart Icon_2.svg",
                     color:  cubit.showProductModel!.data!.added_to_favouries==1
                         ?
                     const Color(0xFFFF4848)
                         : const Color(0xFFDBDEE4),
                     // colorFilter: ColorFilter.mode(
                     // cubit.showProductModel!.data!.added_to_favouries==1
                     //       ?
                     //     const Color(0xFFFF4848)
                     //     : const Color(0xFFDBDEE4),
                     //     BlendMode.srcIn),
                     height: 16,
                   ),
                 ),
               ),
             ),

             Padding(
               padding: const EdgeInsets.only(
                 left: 20,
                 right: 64,
               ),
               child:   HtmlToRichTextWidget(htmlString: cubit.showProductModel!.data!.desctiption??"",),

               // Text(
               //   tr(TextApp.AED),
               //   tr(TextApp.writeDescription),
                 // maxLines: 3,
               // ),
             ),
             // Padding(
             //   padding: const EdgeInsets.symmetric(
             //     horizontal: 20,
             //     vertical: 12,
             //   ),
             //   child: GestureDetector(
             //     onTap: () {},
             //     child: Row(
             //       children: [
             //         Text(
             //           tr(TextApp.moreDetails),
             //           style: TextStyle(
             //               fontWeight: FontWeight.w600, color: kPrimaryColor),
             //         ),
             //         const SizedBox(width: 5),
             //         Icon(
             //           Icons.arrow_forward_ios,
             //           size: 12,
             //           color: kPrimaryColor,
             //         ),
             //       ],
             //     ),
             //   ),
             // )
           ],
         );
      },

   );
  }
}
