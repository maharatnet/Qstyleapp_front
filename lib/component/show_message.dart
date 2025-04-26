// import 'package:gold_market/component/color_manger.dart';
// import 'package:gold_market/component/utility.dart';
// import 'package:flutter/material.dart';
//
//
//
// void showMessage({required BuildContext context,Color color =Colors.green, required String text}) async {
//   OverlayState? overlayState = Overlay.of(context);
//   OverlayEntry overlay1;
//   overlay1 = OverlayEntry(builder: (context) {
//     return Positioned(
//       left: MediaQuery
//           .of(context)
//           .size
//           .width * 0.1,
//       top: MediaQuery
//           .of(context)
//           .size
//           .height * 0.1,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           padding: EdgeInsets.all(MediaQuery
//               .of(context)
//               .size
//               .height * 0.02),
//           width: MediaQuery
//               .of(context)
//               .size
//               .width * 0.8,
//           height: MediaQuery
//               .of(context)
//               .size
//               .height * 0.11,
//           color: color,
//           // color: Colors.orange.withOpacity(0.5),
//           child: Material(
//             color: Colors.transparent,
//             child: Row(
//               children: [
//                 Container(
//                   height: 50,
//                   width: 50,
//                   decoration: BoxDecoration(
//                       color: ColorManager.backgroundColor,
//                       borderRadius: BorderRadius.circular(80),
//                       image: DecorationImage(image: Utility.PlatformAwareAssetImage("assets/alandalusmalllogo.png",),fit: BoxFit.fill)
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(text,
//                       textAlign: TextAlign.end,
//                       style: TextStyle(
//                           fontSize: MediaQuery
//                               .of(context)
//                               .size
//                               .height * 0.024,
//                           //fontWeight: FontWeight.bold,
//                           color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   });
//   overlayState?.insertAll([overlay1]);
//
//   await Future.delayed(const Duration(seconds: 3));
//
//   overlay1.remove();
// }
