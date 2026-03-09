import 'dart:io';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/constant.dart';
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
        // appBar: AppBar(
        //   elevation: 0,
        //   // backgroundColor: Colors.black,
        //   iconTheme: const IconThemeData(
        //     color: Colors.white,
        //   ),
        // ),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: PhotoView(
                // enableRotation: true,
                backgroundDecoration: BoxDecoration(
                  color: ColorManager.white
                ),
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
            Padding(
              padding: const EdgeInsets.only(top: 40.0,right: 20,left: 20),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // shape: BoxShape.circle,
                    color: kPrimaryColor,
                  ),
                  child: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
