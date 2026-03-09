import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/rounded_icon_btn.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/home/show_products_response_model.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/category_details/cubit/category_details_cubit.dart';

// class ColorDots extends StatefulWidget {
//   const ColorDots({Key? key}) : super(key: key);
//
//   @override
//   State<ColorDots> createState() => _ColorDotsState();
// }
//
// class _ColorDotsState extends State<ColorDots> {
//   final List<Color> colorList = [
//     Colors.black,
//     Colors.green,
//     Colors.red,
//     Colors.deepPurple,
//     Colors.deepOrange
//   ];
//
//   int selectedColorIndex = 0;
//   int quantity = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//
//               Text(tr(TextApp.selectSize),style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16),),
//           // Text("Colors:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               ...List.generate(colorList.length, (index) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedColorIndex = index;
//                     });
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.only(right: 8),
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: selectedColorIndex == index ? kPrimaryColor : Colors.transparent,
//                         width: 2,
//                       ),
//                     ),
//                     child: CircleAvatar(
//                       backgroundColor: colorList[index],
//                       radius: 14,
//                     ),
//                   ),
//                 );
//               }),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//
//             children: [
//               // Text("Qty :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//               const Spacer(),
//               RoundedIconBtn(
//                 icon: Icons.remove,
//                 press: () {
//                   if (quantity > 1) {
//                     setState(() {
//                       quantity--;
//                     });
//                   }
//                 },
//               ),
//               const SizedBox(width: 10),
//               Text(quantity.toString(), style: TextStyle(fontSize: 16)),
//               const SizedBox(width: 10),
//               RoundedIconBtn(
//                 icon: Icons.add,
//                 press: () {
//                   setState(() {
//                     quantity++;
//                   });
//                 },
//               ),
//               // const Spacer(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class ColorDots extends StatefulWidget {
   List<ColorModel>? colors;
  Function()ontap;
   ColorDots({Key? key, required this.colors,required this.ontap}) : super(key: key);

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {


  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;

    return BlocConsumer<CategoryDetailsCubit,CategoryDetailsStates>(
      listener: (context,state){},
      builder: (context,state){
        final cubit = CategoryDetailsCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(colors!.isNotEmpty)
              Text(
                tr(TextApp.selectColor),
                style: getBoldStyle(color: Colors.black, fontSize: FontSize.s16),
              ),
              if(colors!.isNotEmpty)
                const SizedBox(height: 8),
              // عرض الألوان من السيرفر
              Row(
                children: List.generate(colors!.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      // setState(() {

                        cubit.colorModel = colors![index];
                        cubit.selectedColorIndex = index;
                        widget.ontap();
                        cubit.refreshData();
                      // });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: cubit.selectedColorIndex == index
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: colors![index].color,
                        radius: 14,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 16),

              // عداد الكمية
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedIconBtn(
                    icon: Icons.remove,
                    press: () {
                      if (cubit.quantity > 1) {
                        // setState(() {
                          cubit.quantity--;

                          cubit.refreshData();
                          widget.ontap();
                        // });
                      }
                    },
                  ),
                  const SizedBox(width: 12),
                  Text(
                    cubit.quantity.toString(),
                    style: getBoldStyle(color: Colors.black, fontSize: FontSize.s16),
                  ),
                  const SizedBox(width: 12),
                  RoundedIconBtn(
                    icon: Icons.add,
                    press: () {
                      // setState(() {
                        cubit.quantity++;
                        cubit.refreshData();
                        widget.ontap();
                      // });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
