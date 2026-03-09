import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/custom_button.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/core/zeina_payment/ziin_call.dart';
import 'package:maharat_ecommerce/model/address/address_response_model.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/cart/cubit/cart_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/my_location/select_address_screen.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutCard extends StatelessWidget {
  double total_value = 0;

  CheckoutCard({Key? key, required this.total_value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = CartCubit.get(context);
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          // height: 174,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: const Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset("assets/icons/receipt.svg"),
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          navigateTo(
                              context,
                              SelectAddressScreen(
                                addressModel: cubit.addressModel,
                                function: (AddressModel? value) {
                                  cubit.addressModel = value;
                                  // print("start");
                                  cubit.getCartApiTwo(
                                      context, value!.id ?? 0);
                                  cubit.refreshData();
                                  Navigator.pop(context);
                                  // if(value!=null) {

                                  // }
                                },
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: cubit.addressModel == null
                                  ? ColorManager.primary.withOpacity(.15)
                                  : ColorManager.secondColor.withOpacity(.2),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(cubit.addressModel == null
                              ? tr(TextApp.selectLocation)
                              : cubit.addressModel!.country?.name ?? ""),
                        )),
                    // const Text("Add voucher code"),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kTextColor,
                    )
                  ],
                ),
                if(cubit.addressModel!=null&&cubit.addressModel!.country!=null)
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 20,
                      child: Text(
                        tr(TextApp.total1),
                        style: getBoldStyle(
                            color: kPrimaryColor, fontSize: FontSize.s14),
                      ),
                    ),
                    // SizedBox(width: 20,),
                    Text(cubit.cartResponseModel!.cartTotal.toString()+" "+tr(TextApp.AED),style: getBoldStyle(
                      // Text(cubit.addressModel!.country!.shippingFees.toString()+" "+tr(TextApp.AED),style: getBoldStyle(
                        color: kPrimaryColor, fontSize: FontSize.s14),),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        tr(TextApp.discount),
                        style: getBoldStyle(
                            color: Colors.red, fontSize: FontSize.s14),
                      ),
                    ),
                    // SizedBox(width: 20,),
                    Text(cubit.cartResponseModel!.discount.toString()+" "+tr(TextApp.AED),style: getBoldStyle(
                      // Text(cubit.addressModel!.country!.shippingFees.toString()+" "+tr(TextApp.AED),style: getBoldStyle(
                        color: Colors.red, fontSize: FontSize.s14),),
                  ],
                ),
                // if(cubit.addressModel!=null&&cubit.addressModel!.country!=null)

                if(cubit.addressModel!=null&&cubit.addressModel!.country!=null)
                Row(
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        tr(TextApp.payment_fees),
                        style: getBoldStyle(
                            color: Colors.black, fontSize: FontSize.s14),
                      ),
                    ),
                    // SizedBox(width: 20,),
                    Text(cubit.cartResponseModel!.shipping_fees.toString()+" "+tr(TextApp.AED),style: getBoldStyle(
                    // Text(cubit.addressModel!.country!.shippingFees.toString()+" "+tr(TextApp.AED),style: getBoldStyle(
                        color: Colors.black, fontSize: FontSize.s14),),
                  ],
                ),
                // if(cubit.addressModel!=null&&cubit.addressModel!.country!=null)

                // const SizedBox(height: 16),
                if(!cubit.is_update)
                Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: tr(TextApp.total),
                          style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s18),
                          children: [
                            TextSpan(
                              text:cubit.cartResponseModel!.total.toString()??"0.0"
                              // cubit.addressModel!=null&&cubit.addressModel!.country!=null?(cubit.addressModel!.country!.shippingFees!+total_value).toString()+" " +
                              //     tr(TextApp.AED):total_value.toString() +
                                  " " +
                                  tr(TextApp.AED), //"337.15",
                              style: getBoldStyle(
                                  fontSize: 16, color: ColorManager.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                          isBuy: cubit.is_wait_create,
                          onTap: () {
                            if (cubit.addressModel == null) {
                              appToast(
                                  message: tr(TextApp.please_enter_location),
                                  type: ToastType.error,
                                  context: context);
                            } else {
                              if(cubit.addressModel!=null&&cubit.addressModel!.country!=null){
                                // cubit.createPaymentIntent(
                                //     ((cubit.addressModel!.country!.shippingFees!+total_value) * 100).toString(),
                                //     "AED",
                                //     context);
                                startZiinaPayment(context,cubit.cartResponseModel!.total??0.0);
                                // startZiinaPayment(context,((cubit.addressModel!.country!.shippingFees!+total_value) * 1).toDouble());
                              }else {
                                startZiinaPayment(context,cubit.cartResponseModel!.total??0.0);

                                // startZiinaPayment(context,((cubit.addressModel!.country!.shippingFees!+total_value) * 1).toDouble());
                                // startZiinaPayment(context,double.parse(((cubit.addressModel!.country!.shippingFees!+total_value) * 100).toString()));

                                // cubit.createPaymentIntent(
                                //     (total_value * 100).toString(),
                                //     "AED",
                                //     context);
                              }
                            }
                          },
                          backgroundColor: ColorManager.secondColor,
                          textColor: ColorManager.white,
                          buttonText: tr(TextApp.checkOut)),
                    ),
                    // Expanded(
                    //   child:
                    //   ElevatedButton(
                    //     onPressed: () {},
                    //     child: const Text("Check Out"),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CheckoutCardShimmer extends StatelessWidget {
  const CheckoutCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(height: 40, width: 40, color: Colors.white),
                const Spacer(),
                Container(height: 20, width: 100, color: Colors.white),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Container(height: 20, color: Colors.white)),
                const SizedBox(width: 10),
                Expanded(child: Container(height: 45, color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
