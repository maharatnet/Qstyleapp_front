import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoadingComponent extends StatelessWidget {
  final ImageChunkEvent? loadingProgress;
  final double? width;
  final double? height;
  final double? size;

  const ImageLoadingComponent(
      {this.loadingProgress, this.width, this.height, this.size, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[400]!,
      child: SizedBox(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        child: Center(
            child: Icon(
              Icons.image_sharp,
              color: Colors.grey,
              size: size ?? 50,
            )),
      ),
    );
  }
}
