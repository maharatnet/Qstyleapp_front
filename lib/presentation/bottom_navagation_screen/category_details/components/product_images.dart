import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/enums.dart';
import 'package:maharat_ecommerce/component/loading_image/image_component.dart';
import 'package:maharat_ecommerce/component/loading_image/photo_screen.dart';
import 'package:maharat_ecommerce/model/home/show_products_response_model.dart';


class ProductImages extends StatefulWidget {
  final List<ImagesModel> imageList;
   ProductImages({
    Key? key,
    required this.imageList,
  }) : super(key: key);

  // final Product product;
// List<String> imageList = [
//   "assets/images/ps4_console_white_1.png",
//   "assets/images/ps4_console_white_2.png",
//   "assets/images/ps4_console_white_3.png",
//   "assets/images/ps4_console_white_4.png",
//
// ];

@override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              // print("Asddsssss");
              navigateTo(context,PhotoScreen(image:widget.imageList[selectedImage].image??"" ,imageFrom: ImageFrom.network,));
            },
            child: SizedBox(
              height: 340,
              width: MediaQuery.sizeOf(context).width,
              child: AspectRatio(
                aspectRatio: 1.5,
                // aspectRatio: 1.4,
                child:ImageComponent(
                    path: widget.imageList[selectedImage].image??"",
                fit: BoxFit.cover,
                ),
                // Image.asset(widget.imageList[selectedImage]),
                // child: Image.asset(widget.product.images[selectedImage]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  backgroundColor: Colors.white,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ...List.generate(
                      widget.imageList.length,
                      // widget.product.images.length,
                          (index) => SmallProductImage(
                        isSelected: index == selectedImage,
                        press: () {
                          setState(() {
                            selectedImage = index;
                          });
                        },
                        image:widget.imageList[index].image??"",
                        // image: widget.product.images[index],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          // SizedBox(height: 20),

        ],
      ),
    );
  }
}

class SmallProductImage extends StatefulWidget {
  const SmallProductImage(
      {super.key,
      required this.isSelected,
      required this.press,
      required this.image});

  final bool isSelected;
  final VoidCallback press;
  final String image;

  @override
  State<SmallProductImage> createState() => _SmallProductImageState();
}

class _SmallProductImageState extends State<SmallProductImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(0),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
                width: widget.isSelected ? 2 : 1,
              color: kPrimaryColor.withOpacity(widget.isSelected ? 1 : 0)),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ImageComponent(path:widget.image,fit: BoxFit.fill,)),
        // child: Image.asset(widget.image),
      ),
    );
  }
}
