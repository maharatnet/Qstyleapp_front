import 'package:flutter/material.dart';

class ImageErrorComponent extends StatelessWidget {
  final double width;
  final double height;
  final double? size;
  final BorderRadiusGeometry? borderRadius;
  const ImageErrorComponent(
      {Key? key,
        required this.height,
        required this.width,
        this.size,
        this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(18),
          color: Colors.black38),
      child: Icon(
        Icons.broken_image_rounded,
        color: Colors.grey[400],
        size: size ?? 40,
      ),
    );
  }
}
