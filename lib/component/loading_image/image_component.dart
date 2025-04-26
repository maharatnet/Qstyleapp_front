
import 'package:maharat_ecommerce/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/loading_image/photo_screen.dart';
import 'image_error_component.dart';
import 'image_loading_component.dart';
class ImageComponent extends StatelessWidget {
  final String path;
  final double radius;
  final double? width;
  final double? height;
  final double? size;
  final BoxFit fit;
  final bool openPhoto;
  final BorderRadiusGeometry? customRadius;

  /// image component (loading and error)
  const ImageComponent(
      {Key? key,
        required this.path,
        this.width,
        this.height,
        this.size,
        this.radius = 0,
        this.fit = BoxFit.cover,
        this.customRadius,
        this.openPhoto = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !openPhoto
          ? null
          : () {
       navigateTo(context, PhotoScreen(image: path));
      },
      borderRadius: BorderRadius.circular(radius),
      child:path.contains(".svg")?Container(
        width: width,
        height: height,
        child: SvgPicture.network(
          path,
          width: width,
          height: height,
          fit: fit,// ColorManager.white,

        ),
      ): Image.network(
        path,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return ImageLoadingComponent(
              width: width, height: height, size: size);
        },
        errorBuilder: (context, _, __) => ImageErrorComponent(
          height: height ?? double.infinity,
          width: width ?? double.infinity,
          size: size,
          borderRadius: customRadius ?? BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
