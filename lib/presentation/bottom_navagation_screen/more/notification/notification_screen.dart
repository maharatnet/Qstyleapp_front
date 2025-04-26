import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/constant.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';

class NotificationsScreen extends StatelessWidget {
  final List<NotificationModel> notifications = [
    NotificationModel(
      title: 'تم إضافة منتج جديد',
      description: 'تمت إضافة فستان جديد في قسم النساء.',
      isRead: false,
    ),
    NotificationModel(
      title: 'عرض خاص',
      description: 'خصم 50% على الأحذية لفترة محدودة.',
      isRead: true,
    ),
    NotificationModel(
      title: 'تم شحن طلبك',
      description: 'طلبك رقم #12345 تم شحنه بنجاح.',
      isRead: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإشعارات',style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s18),),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return NotificationCard(item: item);
        },
      ),
    );
  }
}

class NotificationModel {
  final String title;
  final String description;
  final bool isRead;

  NotificationModel({
    required this.title,
    required this.description,
    required this.isRead,
  });
}

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
                  item.title,
                  style: getBoldStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color:  Colors.black54 ,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  item.description,
                  style: getBoldStyle(
                    fontSize: 14,
                    color:  Colors.black38 ,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "12/4/2025",
                      style: getBoldStyle(
                        fontSize: 12,
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
