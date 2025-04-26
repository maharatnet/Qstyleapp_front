import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/core/custom_loading.dart';
import 'package:maharat_ecommerce/presentation/splash_screen/splash_cubit.dart';

import '../../component/image_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => OnSplashCubit()..initSplash(context),
        child: BlocConsumer<OnSplashCubit, OnSplashState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = OnSplashCubit.get(context);

            return Scaffold(
              body: Container(
                // color: AppColors.primaryColor,
                child: Stack(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Positioned.fill(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         begin: Alignment.topLeft,
                    //         end: Alignment.bottomRight,
                    //         colors: [
                    //           Color(0xFF3A9FA6),
                    //           Color(0xFF0F70B7),
                    //           Color(0xFF4F51DF),
                    //           Color(0xFF4F51DF),
                    //         ],
                    //         stops: [0.0, 0.5,.8, 1.0],
                    //         tileMode: TileMode.clamp,
                    //       ),
                    //     ),
                    //     child: Center(
                    //         child: Image.asset(
                    //           ImageAssets.whiteLogo,
                    //           height: 54,
                    //         )),
                    //   ),
                    // ),
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          // gradient: LinearGradient(
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          //   colors: [
                          //     Color(0xFF1283EC), // الأزرق الفاتح في الأعلى
                          //     // Color(0xFF348E94), // الأزرق الفاتح في الأعلى
                          //     // Color(0xFF3A9FA6), // الأزرق الفاتح في الأعلى
                          //     Color(0xFF0F70B7), // أزرق وسط
                          //     Color(0xFF4F51DF), // أزرق غامق
                          //   ],
                          //   stops: [0.0, 0.55, 1.0],
                          //   tileMode: TileMode.clamp,
                          // ),
                        ),
                        child: Center(
                          child: Image.asset(
                            ImageAssets.logo,
                            height: 120,
                            width: 200,


                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height * .7),
                      child: const CustomLoading(),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //       top: MediaQuery.sizeOf(context).height * .9),
                    //   child: Center(
                    //     child: Text(
                    //       AppConstantsVersion.versionName +
                    //           " " +
                    //           AppConstantsVersion.version,
                    //       style: getBoldStyle(color: ColorManager.white),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
