import 'dart:io';
import 'package:maharat_ecommerce/component/enums.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoScreen extends StatelessWidget {
  final String image;
  final ImageFrom imageFrom;

  const PhotoScreen({
    super.key,
    required this.image,
    this.imageFrom = ImageFrom.network,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          color: Colors.black,
          child: PhotoView(
            imageProvider: imageFrom == ImageFrom.network
                ? NetworkImage(image)
                : imageFrom == ImageFrom.asset
                ? AssetImage('assets/images/$image')
                : FileImage(File(image)) as ImageProvider,
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
            customSize:
            imageFrom == ImageFrom.asset ? Size(200, 200) : null,
          ),
        ),
      ),
    );
  }
}
