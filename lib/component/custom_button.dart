
import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/dimensions.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String? buttonText;
  final bool isBuy;
  final bool isBorder;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? radius;
  final double? fontSize;
  final String? leftIcon;
  final double? borderWidth;
  final double? width;

  const CustomButton({Key? key, this.onTap,this.width, required this.buttonText, this.isBuy= false, this.isBorder = false, this.backgroundColor, this.radius, this.textColor, this.fontSize, this.leftIcon, this.borderColor, this.borderWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      // TextButton(
      // onPressed: onTap,
      // style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
      //
      GestureDetector(
        onTap: onTap,

        child: Container(

          child: ClipPath(
            clipper: CustomRectangleClipper(),
            // Container(height: 45,
            //   width: width==null?MediaQuery.sizeOf(context).width:width,
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //       border: isBorder? Border.all(color: borderColor??Theme.of(context).primaryColor, width:  borderWidth ??1): null,
            //       color:  backgroundColor ?? (isBuy? const Color(0xffFE961C) : Theme.of(context).primaryColor),
            //       borderRadius: BorderRadius.circular(radius !=null ? radius! : isBorder? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall)),
            //
            child:
            Container(height: 70,
              width:MediaQuery.sizeOf(context).width*.8 ,
              // width==null?MediaQuery.sizeOf(context).width:width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: isBorder? Border.all(color: borderColor??Theme.of(context).primaryColor, width:  borderWidth ??1): null,
                color:  backgroundColor ?? (isBuy? const Color(0xffFE961C) : Theme.of(context).primaryColor),
                // borderRadius: BorderRadius.circular(radius !=null ? radius! : isBorder? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall)
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  if(leftIcon != null)
                    Padding(padding: const EdgeInsets.only(right: 5),
                      child: SizedBox(width: 30, child: Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                        child: Image.asset(leftIcon!),
                      )),
                    ),
                  Flexible(
                      child:isBuy?Center(child: CircularProgressIndicator(),): Text(buttonText??"", style:getBoldStyle(fontSize: fontSize?? 16,
                          color: textColor ??  Theme.of(context).highlightColor),
                      )),

                ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}
// import 'package:flutter/material.dart';

class CustomRectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // الجزء العلوي
    path.lineTo(0, size.height * 0.2); // ارفع الجزء العلوي هنا
    path.lineTo(size.width, size.height * 0.5);

    // اكمل الرسم حتى النهاية
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomRectangleClipper oldClipper) => false;
}