import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/empty_component.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/notification/notification_response_model.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navigation_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/notification/cubit/Notification_cubit.dart';
import 'package:shimmer/shimmer.dart';

class NotificationsScreen extends StatelessWidget {
  // final List<NotificationModel> notifications = [
  //   NotificationModel(
  //     title: TextApp.new_product_added,
  //     description: TextApp.new_dress_added_women_section,
  //     isRead: false,
  //   ),
  //   NotificationModel(
  //     title: TextApp.new_product_added,
  //     description: TextApp.new_dress_added_women_section,
  //     isRead: true,
  //   ),
  //   NotificationModel(
  //     title: TextApp.new_product_added,
  //     description: TextApp.new_dress_added_women_section,
  //     isRead: false,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>NotificationCubit()
      ..getNotificationApi(context)

      ,
    child: BlocConsumer<NotificationCubit,NotificationStates>(
        listener: (context,state){},
      builder: (context,state){
          final cubit = NotificationCubit.get(context);
          return WillPopScope(
              onWillPop: () async {
                BottomNavigationCubit.get(context).getNotificationApi(context);
                Navigator.pop(context);
                return false; // لمنع الخروج التلقائي
              },
              // child:
            child: Scaffold(
              appBar: AppBar(
                title: Text(tr(TextApp.notification),style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s18),),
                centerTitle: true,
                leading: IconButton(onPressed: (){
                  BottomNavigationCubit.get(context).getNotificationApi(context);
                  Navigator.pop(context);
                }, icon: Icon(SharedPreferenceGetValue.getLanguage()=="ar"?Icons.arrow_back_ios:Icons.arrow_back_ios)),
              ),
              body:cubit.is_Notification_data||state is LoadingNotificationDataNewStates
                  ? ListView.builder(
                itemCount: 5,
                itemBuilder: (_, __) => const NotificationCardShimmer(),
              )
                  : cubit.notificationResponseModel == null ||
                  cubit.notificationResponseModel!.data == null ||
                  cubit.notificationResponseModel!.data!.length == 0
                  ? Expanded(child: EmptyComponent(title: tr(TextApp.no_data)))
                  :  ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount:  cubit.notificationResponseModel!.data!.length,
                itemBuilder: (context, index) {
                  final item =  cubit.notificationResponseModel!.data![index];
                  return NotificationCard(item: item);
                },
              ),
            ),
          );
      },
    ),
    );
  }
}

// class NotificationModel {
//   final String title;
//   final String description;
//   final bool isRead;
//
//   NotificationModel({
//     required this.title,
//     required this.description,
//     required this.isRead,
//   });
// }

class NotificationCard extends StatelessWidget {
  final NotificationModel item;

  const NotificationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:Colors.grey.shade100, //item.isRead ? Colors.grey.shade100 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:// item.isRead ?
          Colors.grey.shade300,
              // : Colors.blue,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/Bell.svg",
            color: kPrimaryColor,
            width: 22,
          ),
          // CircleAvatar(
          //   backgroundColor: Colors.blue,
          //   child: Icon(Icons.notifications, color: Colors.white),
          // ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title??"",
                  style: getBoldStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color:  Colors.black54 ,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  item.body??"",
                  style: getBoldStyle(
                    fontSize: 14,
                    color:  Colors.black38 ,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Text(item!.data==null?"":item!.data!.status==null?"":item!.data!.status!.status??"",
                          style: getBoldStyle(
                            fontSize: 11,
                            color:  ColorManager.primary ,
                          ),
                        )),
                    SizedBox(width: 12,),
                    Text(
                      item.createdAt??"",
                      // "12/4/2025",
                      style: getBoldStyle(
                        fontSize: 11,
                        color:  ColorManager.primary ,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationCardShimmer extends StatelessWidget {
  const NotificationCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 12,
                      width: 80,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}