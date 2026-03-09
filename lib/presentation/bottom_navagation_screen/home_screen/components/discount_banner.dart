import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/loading_image/image_component.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/home/banner_response_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DiscountBanner extends StatefulWidget {
  final List<BannerModel>? banner;
  final Function (String url)? onClick;
  const DiscountBanner({Key? key, this.banner,this.onClick}) : super(key: key);

  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final banners = widget.banner;

    if (banners == null || banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CarouselSlider.builder(
              itemCount: banners.length,
              itemBuilder: (context, index, realIndex) {
                final item = banners[index];
                return GestureDetector(
                  onTap: (){
                    widget.onClick!(banners[index].url??"");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ImageComponent(
                        path: item.image ?? "",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 160,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(banners.length, (index) {
              return GestureDetector(
                onTap:(){
                  // widget.onClick!(banners[index].url??"");
                 },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? ColorManager.black
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// class DiscountBanner extends StatelessWidget {
//  List<  BannerModel> ? banner;
//    DiscountBanner({
//     Key? key,
//     this.banner,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return banner==null||banner!.length==0?Text(""):
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: CarouselSlider(
//         // options: CarouselOptions(height: 200.0),
//         options: CarouselOptions(
//           height: 150,
//           viewportFraction: 1.0,
//           autoPlay: true,
//           onPageChanged: (index, reason) {
//
//             // cubit.currentIndex = index;
//             // cubit.refreshData();
//           },
//         ),
//         items: banner!
//         // ["assets/images/Image Banner 2.png"
//         //   ,"assets/images/Image Banner 3.png",
//         //   "assets/images/Image Banner 2.png",
//         //   "assets/images/Image Banner 3.png",
//         //   "assets/images/Image Banner 2.png"]
//             .map((i) {
//           return Builder(
//             builder: (BuildContext context) {
//               return Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: EdgeInsets.symmetric(horizontal: 0.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12)
//                       // color: Colors.amber
//                   ),
//                   child:ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: ImageComponent(path: i.image??"",
//
//                     ),
//                   ),
//                   // ImageComponent(path: i,
//                   //
//                   // )  //Text('text $i', style: TextStyle(fontSize: 16.0),)
//               );
//             },
//           );
//         }).toList(),
//             ),
//       );
//
//     // const SizedBox(height: 10),
//     // Row(
//     // mainAxisAlignment: MainAxisAlignment.center,
//     // children: List.generate(3, (index) {
//     // return Container(
//     // width: index == cubit.currentIndex ? 30 : 6,
//     // height: 6,
//     // margin: const EdgeInsets.symmetric(horizontal: 4),
//     // decoration: BoxDecoration(
//     // color: index == cubit.currentIndex ? Colors.red : Colors.grey.shade300,
//     // borderRadius: BorderRadius.circular(3),
//     // ),
//     // );
//     // }),
//     // ),
//     ///----------------------
//     // return Container(
//     //   width: double.infinity,
//     //   margin: const EdgeInsets.all(20),
//     //   padding: const EdgeInsets.symmetric(
//     //     horizontal: 20,
//     //     vertical: 16,
//     //   ),
//     //   decoration: BoxDecoration(
//     //     color: const Color(0xFF4A3298),
//     //     borderRadius: BorderRadius.circular(20),
//     //   ),
//     //   child: const Text.rich(
//     //     TextSpan(
//     //       style: TextStyle(color: Colors.white),
//     //       children: [
//     //         TextSpan(text: TextApp.summerSurprise),
//     //         TextSpan(
//     //           text: TextApp.cashback,
//     //           style: TextStyle(
//     //             fontSize: 24,
//     //             fontWeight: FontWeight.bold,
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }


class DiscountBannerShimmer extends StatelessWidget {
  const DiscountBannerShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CarouselSlider.builder(
          itemCount: 5, // نفس عدد الصور الحقيقية
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
          options: CarouselOptions(
            height: 150,
            viewportFraction: 1.0,
            autoPlay: false,
          ),
        ),
      ),
    );
  }
}