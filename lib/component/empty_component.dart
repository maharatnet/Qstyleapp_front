
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class EmptyComponent extends StatelessWidget {
  final String title;
  final String path;
  final bool withImage;
  final double? height;
  final double? heightSizedBox;
  final double? minHeight;
  final double? maxHeight;

  const EmptyComponent(
      {Key? key,
      required this.title,
      this.path = 'noData',
      this.height,
      this.heightSizedBox,
      this.minHeight,
      this.maxHeight,
      this.withImage = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (withImage)
          Center(
            child: SizedBox(
              height: 140,
              child: OverflowBox(
                minHeight: minHeight ?? 200,
                maxHeight: maxHeight ?? 200,
                child: Lottie.asset(
                    'assets/animations/$path.json',
                    height: height ?? 200,
                    repeat: true),
              ),
            ),
          ),
        // Center(
        //   child: FractionallySizedBox(
        //     heightFactor: 1.8,
        //     child: Lottie.asset('${Constants.ASSETS_ANIMATIONS_PATH}$path.json',
        //         height: height ?? 220.h, repeat: true),
        //   ),
        // ),
        if (heightSizedBox != null) SizedBox(height: heightSizedBox),
        Text(title,
            textAlign: TextAlign.center,
            style: getBoldStyle(
                fontSize: 17,
            color: ColorManager.black,
            )),
      ],
    );
  }
}
