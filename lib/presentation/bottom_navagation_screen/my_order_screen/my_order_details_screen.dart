// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
// import 'package:maharat_ecommerce/core/textApp.dart';
// import 'package:maharat_ecommerce/model/order/order_details_response_model.dart';
// import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/my_order_screen/my_order_cubit.dart';

// class OrderDetailsScreen extends StatefulWidget {
//   final int? orderId;
//
//   const OrderDetailsScreen({Key? key, this.orderId}) : super(key: key);
//
//   @override
//   _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
// }
//
// class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // استدعاء تفاصيل الطلب عند فتح الشاشة
//     context.read<MyOrderCubit>().getOrderDetailsApi(context, widget.orderId!);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: Text(
//           'تفاصيل الطلب',
//           style: getBoldStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.black[600],
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh, color: Colors.white),
//             onPressed: () =>     context.read<MyOrderCubit>().getOrderDetailsApi(context, widget.orderId!)
//             ,
//           ),
//         ],
//       ),
//       body: BlocConsumer<MyOrderCubit, MyOrderStates>(
//         listener: (context, state) {
//           // عرض Toast عند حدوث خطأ
//           if (state is ErrorOrderDetailsDataStates) {
//             appToast(
//               message: tr(TextApp.errorMessage),
//               type: ToastType.error,
//               context: context,
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is LoadingOrderDetailsDataStates) {
//             return _buildLoadingState();
//           } else if (state is SuccessOrderDetailsDataStates) {
//             return _buildOrderDetails(context);
//           } else if (state is ErrorOrderDetailsDataStates) {
//             return _buildErrorState(context);
//           }
//           return _buildInitialState(context);
//         },
//       ),
//     );
//   }
//
//   Widget _buildLoadingState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.black[600]!),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'جاري تحميل تفاصيل الطلب...',
//             style: getBoldStyle(
//               fontSize: 16,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOrderDetails(BuildContext context) {
//     final cubit = MyOrderCubit.get(context);
//     final orderDetails = cubit.orderDetailsResponseModel;
//
//     if (orderDetails == null) {
//       return _buildEmptyState();
//     }
//
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // معلومات الطلب الأساسية
//           _buildOrderInfoCard(orderDetails),
//           SizedBox(height: 16),
//
//           // حالة الطلب
//           _buildOrderStatusCard(orderDetails),
//           SizedBox(height: 16),
//
//           // عناصر الطلب
//           // _buildOrderItemsCard(orderDetails),
//           SizedBox(height: 16),
//
//           // معلومات الدفع
//           _buildPaymentInfoCard(orderDetails),
//           SizedBox(height: 16),
//
//           // عنوان التوصيل
//           _buildShippingAddressCard(orderDetails),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOrderInfoCard(OrderDetailsResponseModel orderDetails) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.receipt_long, color: Colors.black[600]),
//                 SizedBox(width: 8),
//                 Text(
//                   'معلومات الطلب',
//                   style: getBoldStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ],
//             ),
//             Divider(height: 20),
//             _buildInfoRow('رقم الطلب', '#${orderDetails.data?.id ?? 'غير محدد'}'),
//             _buildInfoRow('تاريخ الطلب', orderDetails.data?.createdAt ?? 'غير محدد'),
//             _buildInfoRow('إجمالي المبلغ', '${orderDetails.data?.total ?? 0} ج.م'),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOrderStatusCard(OrderDetailsResponseModel orderDetails) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.track_changes, color: Colors.green[600]),
//                 SizedBox(width: 8),
//                 Text(
//                   'حالة الطلب',
//                   style: getBoldStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 12),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: _getStatusColor(orderDetails.data?.status!.status??""),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 orderDetails.data?.status!.status ?? 'غير محددة',
//                 style: getBoldStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOrderItemsCard(OrderDetailsResponseModel orderDetails) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.shopping_cart, color: Colors.orange[600]),
//                 SizedBox(width: 8),
//                 Text(
//                   'عناصر الطلب',
//                   style: getBoldStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ],
//             ),
//             Divider(height: 20),
//             // هنا تحط عناصر الطلب لو موجودة في النموذج
//             if (orderDetails.data?.items?.isNotEmpty ?? false)
//               ...orderDetails.data!.items!.map((item) => _buildOrderItem(item))
//             else
//               Text(
//                 'لا توجد عناصر للعرض',
//                 style: getBoldStyle(color: Colors.grey[600]),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOrderItem(dynamic item) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(Icons.image, color: Colors.grey[600]),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.name ?? 'اسم المنتج',
//                   style: getBoldStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'الكمية: ${item.quantity ?? 1}',
//                   style: getBoldStyle(color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             '${item.price ?? 0} ج.م',
//             style: getBoldStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.black[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPaymentInfoCard(OrderDetailsResponseModel orderDetails) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.payment, color: Colors.purple[600]),
//                 SizedBox(width: 8),
//                 Text(
//                   'معلومات الدفع',
//                   style: getBoldStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ],
//             ),
//             Divider(height: 20),
//             _buildInfoRow('طريقة الدفع', orderDetails.data?.paymentMethod ?? 'غير محددة'),
//             _buildInfoRow('حالة الدفع', orderDetails.data?.paymentStatus.toString() ?? 'غير محددة'),
//             _buildInfoRow('المبلغ المدفوع', '${orderDetails.data?.total ?? 0} ج.م'),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildShippingAddressCard(OrderDetailsResponseModel orderDetails) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.location_on, color: Colors.red[600]),
//                 SizedBox(width: 8),
//                 Text(
//                   'عنوان التوصيل',
//                   style: getBoldStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ],
//             ),
//             Divider(height: 20),
//             Text(
//               orderDetails.data?.address ?? 'لا يوجد عنوان محدد',
//               style: getBoldStyle(
//                 fontSize: 16,
//                 color: Colors.grey[700],
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: getBoldStyle(
//               color: Colors.grey[600],
//               fontSize: 14,
//             ),
//           ),
//           Text(
//             value,
//             style: getBoldStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Color _getStatusColor(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'pending':
//       case 'قيد الانتظار':
//         return Colors.orange;
//       case 'confirmed':
//       case 'مؤكد':
//         return Colors.black;
//       case 'shipped':
//       case 'تم الشحن':
//         return Colors.purple;
//       case 'delivered':
//       case 'تم التوصيل':
//         return Colors.green;
//       case 'cancelled':
//       case 'ملغي':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.inbox_outlined,
//             size: 80,
//             color: Colors.grey[400],
//           ),
//           SizedBox(height: 16),
//           Text(
//             'لا توجد تفاصيل للعرض',
//             style: getBoldStyle(
//               fontSize: 18,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildErrorState(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error_outline,
//             size: 80,
//             color: Colors.red[300],
//           ),
//           SizedBox(height: 20),
//           Text(
//             'حدث خطأ في تحميل التفاصيل',
//             style: getBoldStyle(
//               fontSize: 18,
//               color: Colors.grey[700],
//             ),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => context.read<MyOrderCubit>().getOrderDetailsApi(context, widget.orderId),
//             child: Text('إعادة المحاولة'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black[600],
//               foregroundColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInitialState(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () => context.read<MyOrderCubit>().getOrderDetailsApi(context, widget.orderId),
//         child: Text('تحميل التفاصيل'),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.black[600],
//           foregroundColor: Colors.white,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/order/order_details_response_model.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/my_order_screen/my_order_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int? orderId;

  const OrderDetailsScreen({Key? key, this.orderId}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.orderId != null) {
        context.read<MyOrderCubit>().getOrderDetailsApi(context, widget.orderId!);
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          tr(TextApp.order_details),
          style: getBoldStyle(
            fontSize: 18,
            // fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        // backgroundColor: Colors.black.withOpacity(.6),
        centerTitle: true,
        elevation: 0,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.refresh, color: Colors.white),
          //   onPressed: () {
          //     context.read<MyOrderCubit>().getOrderDetailsApi(context, widget.orderId!);
          //     _animationController.reset();
          //     _animationController.forward();
          //   },
          // ),
        ],
      ),
      body: BlocConsumer<MyOrderCubit, MyOrderStates>(
        listener: (context, state) {
          if (state is ErrorOrderDetailsDataStates) {
            appToast(
              message: tr(TextApp.errorMessage),
              type: ToastType.error,
              context: context,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingOrderDetailsDataStates) {
            return _buildLoadingState();
          } else if (state is SuccessOrderDetailsDataStates) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: _buildOrderDetails(context),
            );
          } else if (state is ErrorOrderDetailsDataStates) {
            return _buildErrorState(context);
          }
          return _buildInitialState(context);
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(.6)!),
            strokeWidth: 3,
          ),
          SizedBox(height: 20),
          Text(
            tr(TextApp.loading_order_details),
            style: getBoldStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
    final cubit = MyOrderCubit.get(context);
    final orderDetails = cubit.orderDetailsResponseModel;

    if (orderDetails == null) {
      return _buildEmptyState();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderInfoCard(orderDetails),
          SizedBox(height: 16),
          _buildOrderStatusCard(orderDetails),
          SizedBox(height: 16),
          _buildOrderItemsCard(orderDetails),
          SizedBox(height: 16),
          _buildPaymentInfoCard(orderDetails),
          SizedBox(height: 16),
          _buildShippingAddressCard(orderDetails),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOrderInfoCard(OrderDetailsResponseModel orderDetails) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.blue[50]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.receipt_long, color: Colors.white, size: 20),
                ),
                SizedBox(width: 12),
                Text(
                  tr(TextApp.order_info),
                  style: getBoldStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInfoRow(tr(TextApp.order_number), '#${orderDetails.data?.id ?? tr(TextApp.not_specified)}'),
            _buildInfoRow(tr(TextApp.order_date), _formatDate(orderDetails.data?.createdAt)),
            _buildInfoRow(tr(TextApp.total_amount), '${orderDetails.data?.total ?? 0} ${tr(TextApp.AED)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusCard(OrderDetailsResponseModel orderDetails) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.green[50]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.track_changes, color: Colors.white, size: 20),
                ),
                SizedBox(width: 12),
                Text(
                  tr(TextApp.order_status),
                  style: getBoldStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            // SizedBox(height: 16),
            // _buildStatusTimeline(orderDetails.data?.status?.status),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: _getStatusColor(orderDetails.data?.status?.status??""),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: _getStatusColor(orderDetails.data?.status?.status).withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
    orderDetails.data?.status?.status??"",
                // _getStatusText(),
                style: getBoldStyle(
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(String? status) {
    final statuses = ['pending', 'confirmed', 'shipped', 'delivered'];
    final currentIndex = statuses.indexOf(status?.toLowerCase() ?? '');

    return Row(
      children: List.generate(statuses.length, (index) {
        final isActive = index <= currentIndex;
        final isLast = index == statuses.length - 1;

        return Expanded(
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isActive ? Colors.green[600] : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    color: isActive ? Colors.green[600] : Colors.grey[300],
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildOrderItemsCard(OrderDetailsResponseModel orderDetails) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.shopping_cart, color: Colors.white, size: 20),
                ),
                SizedBox(width: 12),
                Text(
                  tr(TextApp.order_items),
                  style: getBoldStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (orderDetails.data?.items?.isNotEmpty ?? false)
              ...orderDetails.data!.items!.map((item) => _buildOrderItem(item)).toList()
            else
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.inbox_outlined, color: Colors.grey[400], size: 30),
                    SizedBox(width: 12),
                    Text(
                      tr(TextApp.no_items_to_display),
                      style: getBoldStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(Items item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 70,
              height: 70,
              child: item.product?.image != null
                  ? CachedNetworkImage(
                imageUrl: item.product!.image!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.broken_image, color: Colors.grey[400]),
                ),
              )
                  : Container(
                color: Colors.grey[200],
                child: Icon(Icons.image, color: Colors.grey[400]),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product?.name ?? tr(TextApp.product_name),
                  style: getBoldStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                if (item.size?.value != null)
                  Text(
                    '${tr(TextApp.size)}: ${item.size!.value}',
                    style: getBoldStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                if (item.color?.value != null)
                  Text(
                    '${tr(TextApp.color)}: ${item.color!.value}',
                    style: getBoldStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                Text(
                  '${tr(TextApp.quantity)}: ${item.quantity ?? 1}',
                  style: getBoldStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${item.price ?? 0} ${tr(TextApp.AED)}',
                style: getBoldStyle(
                  // fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(.6),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${tr(TextApp.total)}: ${item.total ?? 0} ${tr(TextApp.AED)}',
                style: getBoldStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfoCard(OrderDetailsResponseModel orderDetails) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.purple[50]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.payment, color: Colors.white, size: 20),
                ),
                SizedBox(width: 12),
                Text(
                  tr(TextApp.payment_info),
                  style: getBoldStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInfoRow(tr(TextApp.payment_method), orderDetails.data?.paymentMethod ?? tr(TextApp.not_specified)),
            _buildInfoRow(tr(TextApp.payment_status), _getPaymentStatusText(orderDetails.data?.paymentStatus)),
            _buildInfoRow(tr(TextApp.amount_paid), '${orderDetails.data?.total ?? 0} ${tr(TextApp.AED)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingAddressCard(OrderDetailsResponseModel orderDetails) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.location_on, color: Colors.white, size: 20),
                ),
                SizedBox(width: 12),
                Text(
                  tr(TextApp.shipping_address),
                  style: getBoldStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderDetails.data?.country ?? tr(TextApp.no_address_specified),
                    style: getBoldStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      // height: 1.5,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    orderDetails.data?.city ?? "",
                    style: getBoldStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      // height: 1.5,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    orderDetails.data?.description ?? "",
                    style: getBoldStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      // height: 1.5,
                    ),
                  ),
                  // if (orderDetails.data?.latitude != null && orderDetails.data?.longitude != null)
                  //   Padding(
                  //     padding: EdgeInsets.only(top: 12),
                  //     child: ElevatedButton.icon(
                  //       onPressed: () => _openMap(orderDetails.data!.latitude!, orderDetails.data!.longitude!),
                  //       icon: Icon(Icons.map, size: 16),
                  //       label: Text(tr(TextApp.view_on_map)),
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: Colors.green[600],
                  //         foregroundColor: Colors.white,
                  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: getBoldStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: getBoldStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.black;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return tr(TextApp.status_pending);
      case 'confirmed':
        return tr(TextApp.status_confirmed);
      case 'shipped':
        return tr(TextApp.status_shipped);
      case 'delivered':
        return tr(TextApp.status_delivered);
      case 'cancelled':
        return tr(TextApp.status_cancelled);
      default:
        return tr(TextApp.not_specified);
    }
  }

  String _getPaymentStatusText(int? status) {
    switch (status) {
      case 0:
        return tr(TextApp.payment_pending);
      case 1:
        return tr(TextApp.payment_completed);
      case 2:
        return tr(TextApp.payment_failed);
      default:
        return tr(TextApp.not_specified);
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return tr(TextApp.not_specified);

    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy - hh:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }

  void _openMap(String latitude, String longitude) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      appToast(
        message: tr(TextApp.cannot_open_map),
        type: ToastType.error,
        context: context,
      );
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            tr(TextApp.no_details_available),
            style: getBoldStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[300],
          ),
          SizedBox(height: 20),
          Text(
            tr(TextApp.error_loading_details),
            style: getBoldStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<MyOrderCubit>().getOrderDetailsApi(context, widget.orderId),
            child: Text(tr(TextApp.retry)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black.withOpacity(.6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => context.read<MyOrderCubit>().getOrderDetailsApi(context, widget.orderId),
        child: Text(tr(TextApp.load_details)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black.withOpacity(.6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
