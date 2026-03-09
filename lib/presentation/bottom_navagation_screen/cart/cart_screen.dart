import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/empty_component.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/not_login_widget.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/cart/component/cart_card.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/cart/component/checkout_card.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/cart/cubit/cart_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/cart/empty_cart_screen.dart';


class CartScreen extends StatelessWidget {

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return BlocProvider(create: (_)=>CartCubit()..getCartApi(context),
  child: BlocConsumer<CartCubit,CartStates>(
      listener: (context,state){},
     builder: (context,state){
        final cubit = CartCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: SharedPreferenceGetValue.getToken()==null||SharedPreferenceGetValue.getToken()==""?null:AppBar(
              title: Column(
                children: [
                  Text(
                    tr(TextApp.yourCart),
                    style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16),
                  ),
              if(cubit.cartResponseModel!=null&&cubit.cartResponseModel!.data!=null)
                  Text(
                    "${cubit.cartResponseModel!.data!.length} ${tr(TextApp.items)}",
                    style: getBoldStyle(color: Colors.black,fontSize: FontSize.s13),
                  ),
                ],
              ),
              leading: Text(""),
            ),
            body:SharedPreferenceGetValue.getToken()==null||SharedPreferenceGetValue.getToken()==""
                ?NotLoggedInWidget():
            cubit.is_get_data||state is LoadingGetCartState?Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: ListView.builder(
                 itemCount: 3,
                 itemBuilder: (context, index) =>Padding(
             padding: const EdgeInsets.symmetric(vertical: 10),
             child: CartCardShimmer()),))
            :cubit.cartResponseModel==null||cubit!.cartResponseModel!.data==null||cubit.cartResponseModel!.data!.length==0?
            EmptyCartWidget() // EmptyComponent(title: tr(TextApp.no_data))
                  :Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: cubit.cartResponseModel!.data!.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key("$index"),
                    // demoCarts[index].product.id.toString()),
                    direction: DismissDirection.endToStart,
                    // onDismissed: (direction) {
                    confirmDismiss: (direction) async{
                      // setState(() {
                      // cubit.cartResponseModel!.data!.removeAt(index);
                      // });
                      // print(cubit.cartResponseModel!.data![index].toJson());
                      // cubit.deleteCartApi(context, cubit.cartResponseModel!.data![index].product!.id??1 );
                      final productId = cubit.cartResponseModel!.data![index].id ?? 1;

                      final success = await cubit.deleteCartApi(context, productId);

                      if (success) {
                        cubit.cartResponseModel!.data!.removeAt(index);
                        cubit.refreshData();
                        return true;
                      } else {
                        // فشل الحذف - أظهر رسالة للمستخدم
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("فشل في حذف المنتج من السلة")),
                        );
                        return false;
                      }
                    },
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(cartModel: cubit.cartResponseModel!.data![index],),
                  ),
                ),
              ),
            ),
            bottomNavigationBar:cubit.is_get_data||state is LoadingGetCartState?
                  CheckoutCardShimmer()
                  :
            cubit.cartResponseModel==null||cubit!.cartResponseModel!.data==null||
                cubit.cartResponseModel!.data!.length==0?Text(""):
            cubit.cartResponseModel!=null?
            CheckoutCard(total_value:cubit.is_update?0 :cubit!.cartResponseModel!.cartTotal??0,):Text(""),
          ),
        );

     },
  ),
  );
  }
}
