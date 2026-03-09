import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/loading_image/image_component.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/cart/cart_response_model.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/cart/cubit/cart_cubit.dart';
import 'package:shimmer/shimmer.dart';

class CartCard extends StatelessWidget {
  final CartModel cartModel;
   CartCard({
    Key? key,
    required this.cartModel,
  }) : super(key: key);

  // final Cart cart;

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<CartCubit,CartStates>(
      listener:(context,state){},
    builder: (context,state){
        final cubit = CartCubit.get(context);
        return Container(
          color: ColorManager.white,
          child: Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 1.25,
                  child:
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ImageComponent(path: cartModel!.product!.image??""),
                    // child: Image.asset("assets/images/ps4_console_white_2.png"),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartModel!.product!.name??"",
                      // "T-Shirt",
                      style:  getBoldStyle(color: Colors.black, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8),
                    if (cartModel!.product!.discountPrice!=null&&double.parse(cartModel!.product!.discountPrice??"0.0")!>0)
                      Text(
                        "${cartModel!.product!.price}"+tr(TextApp.AED),
                        // TextApp.cost150,
                        // 'خصم ${e.discount}%',
                        style: getRegularLineStyle(color: Colors.red),
                      ),

                    Text(
                      cartModel!.product!.discountPrice!=null&&double.parse(cartModel!.product!.discountPrice??"0.0")!>0?
                      '${cartModel!.product!.discountPrice} '+tr(TextApp.AED):'${cartModel!.product!.price} '

                          +tr(TextApp.AED),
                      style: getBoldStyle(color: Colors.black, fontSize: FontSize.s14),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 40,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap:(){
                        // cartModel!.quantity= (int.parse(cartModel!.quantity??"1")+1).toString();
                        String item= (int.parse(cartModel!.quantity??"1")+1).toString();
                        cubit.updateCartApi(context, cartModel!.id??1,item??"1",(){
                          cartModel!.quantity= (int.parse(cartModel!.quantity??"1")+1).toString();
                        });
                        // cubit.updateCartApi(context, cartModel!.id??1, cartModel!.quantity??"1");

                        cubit.refreshData();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.light_grey.withOpacity(.4),
                        ),
                        child: Icon(Icons.add,size: 20,color: ColorManager.primary,),
                      ),
                    ),
                    SizedBox(height: 2,),
                    Text(cartModel!.quantity??"1",style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                    SizedBox(height: 2,),
                    GestureDetector(
                      onTap: (){
                        if(int.parse(cartModel!.quantity??"1")>1) {
                          String item= (int.parse(cartModel!.quantity ?? "1") - 1).toString();
                          // cartModel!.quantity= (int.parse(cartModel!.quantity ?? "1") - 1).toString();
                          cubit.updateCartApi(context, cartModel!.id??1, item??"1",(){
                            cartModel!.quantity= (int.parse(cartModel!.quantity ?? "1") - 1).toString();
                          });
                          // cubit.updateCartApi(context, cartModel!.id??1, cartModel!.quantity??"1");
                          cubit.refreshData();
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.light_grey.withOpacity(.4),
                        ),
                        child: Icon(Icons.remove,size: 20,color: ColorManager.primary,),
                      ),
                    ),
                  ],),
              ),
              Container(
                width: 8,
                height: 100,
                decoration: BoxDecoration(
                    color: ColorManager.error,
                    borderRadius: BorderRadius.circular(12)
                ),
              ),


            ],
          ),
        );
    },
  );
  }
}

class CartCardShimmer extends StatelessWidget {
  const CartCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20, width: double.infinity, color: Colors.white),
                  const SizedBox(height: 10),
                  Container(height: 15, width: 100, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Container(width: 30, height: 30, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
                const SizedBox(height: 5),
                Container(width: 20, height: 15, color: Colors.white),
                const SizedBox(height: 5),
                Container(width: 30, height: 30, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}