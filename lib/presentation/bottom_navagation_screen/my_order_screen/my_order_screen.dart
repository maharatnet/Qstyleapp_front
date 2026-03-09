import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/order/order_response_model.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/my_order_screen/my_order_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/my_order_screen/my_order_details_screen.dart';

class MyOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyOrderCubit()..getOrderApi(context),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text(
            tr(TextApp.my_orders),
            style: getBoldStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(
              height: 1,
              color: Colors.grey[200],
            ),
          ),
        ),
        body: BlocConsumer<MyOrderCubit, MyOrderStates>(
          listener: (context, state) {
            // Handle any side effects here if needed
          },
          builder: (context, state) {
            final cubit = MyOrderCubit.get(context);

            if (state is LoadingOrderDataStates || cubit.is_get_data) {
              return _buildLoadingWidget();
            }

            if (state is ErrorOrderDataStates) {
              return _buildErrorWidget(context, cubit);
            }

            if (cubit.orderResponseModel?.data?.isEmpty ?? true) {
              return _buildEmptyWidget();
            }

            return _buildOrdersList(cubit.orderResponseModel!.data!);
          },
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            strokeWidth: 3,
          ),
          SizedBox(height: 16),
          Text(
            tr(TextApp.loading_orders),
            style: getBoldStyle(
              fontSize: 16,
              color: Colors.grey[600],
              // fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, MyOrderCubit cubit) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red[300],
            ),
            SizedBox(height: 24),
            Text(
              tr(TextApp.order_error),
              style: getBoldStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              tr(TextApp.check_internet),
              style: getBoldStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => cubit.getOrderApi(context),
              icon: Icon(Icons.refresh),
              label: Text(tr(TextApp.retry)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            SizedBox(height: 24),
            Text(
              tr(TextApp.no_orders),
              style: getBoldStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            Text(
              tr(TextApp.no_orders_message),
              style: getBoldStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate to shopping
              },
              child: Text(tr(TextApp.start_shopping)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(List<OrderModel> orders) {
    return RefreshIndicator(
      onRefresh: () async {
        // Add refresh functionality
      },
      child: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = orders[index];
          return _buildOrderCard(order, context);
        },
      ),
    );
  }

  Widget _buildOrderCard(OrderModel order, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {

            navigateTo(context,BlocProvider.value(value:MyOrderCubit.get(context) ,
              child: OrderDetailsScreen(
                orderId:order.id ,
              ),
            ));
            // _showOrderDetails(context, order);
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${tr(TextApp.order_number)} #${order.id ?? tr(TextApp.not_specified)}',
                      style: getBoldStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    _buildStatusChip(order.status!.status ?? 'غير محدد'),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text(
                      order.createdAt ?? tr(TextApp.not_specified),
                      style: getBoldStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.shopping_cart, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    // Text(
                    //   '${order!.?.length ?? 0} ${(order.items?.length ?? 0) > 1 ? tr(TextApp.products) : tr(TextApp.product)}',
                    //   style: getBoldStyle(
                    //     fontSize: 14,
                    //     color: Colors.grey[600],
                    //   ),
                    // ),
                    Spacer(),
                    Text(
                      '${order.total ?? 0} ${tr(TextApp.AED)}',
                      style: getBoldStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[200],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        navigateTo(context,BlocProvider.value(value:MyOrderCubit.get(context) ,
                          child: OrderDetailsScreen(
                            orderId:order.id ,
                          ),
                        ));
                      },//_showOrderDetails(context, order),
                      icon: Icon(Icons.visibility, size: 16),
                      label: Text(tr(TextApp.view_details)),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                    // if (order.status!.status!.toLowerCase() == 'pending')
                    //   TextButton.icon(
                    //     onPressed: () {},//_cancelOrder(context, order),
                    //     icon: Icon(Icons.cancel, size: 16),
                    //     label: Text(tr(TextApp.cancel_order)),
                    //     style: TextButton.styleFrom(
                    //       foregroundColor: Colors.red,
                    //       padding: EdgeInsets.symmetric(horizontal: 8),
                    //     ),
                    //   ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
        displayText = tr(TextApp.status_pending);
        break;
      case 'confirmed':
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[800]!;
        displayText = tr(TextApp.status_confirmed);
        break;
      case 'delivered':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        displayText = tr(TextApp.status_delivered);
        break;
      case 'cancelled':
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        displayText = tr(TextApp.status_cancelled);
        break;
      default:
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[800]!;
        displayText = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        displayText,
        style: getBoldStyle(
          fontSize: 12,
          // fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Order order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => OrderDetailsBottomSheet(order: order),
    );
  }

  void _cancelOrder(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr(TextApp.cancel_order)),
        content: Text(tr(TextApp.cancel_order_message)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr(TextApp.no)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add cancel order logic here
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(tr(TextApp.yes_cancel)),
          ),
        ],
      ),
    );
  }
}

class OrderDetailsBottomSheet extends StatelessWidget {
  final Order order;

  const OrderDetailsBottomSheet({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                Text(
                  '${tr(TextApp.order_details)} #${order.id}',
                  style: getBoldStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailSection(tr(TextApp.order_info), [
                    _buildDetailRow(tr(TextApp.order_number), '#${order.id}'),
                    _buildDetailRow(tr(TextApp.order_date), order.createdAt ?? tr(TextApp.not_specified)),
                    _buildDetailRow(tr(TextApp.order_status), order.status ?? tr(TextApp.not_specified)),
                    _buildDetailRow(tr(TextApp.total_amount), '${order.totalAmount} ${tr(TextApp.AED)}'),
                  ]),
                  SizedBox(height: 20),
                  _buildDetailSection(tr(TextApp.delivery_info), [
                    _buildDetailRow(tr(TextApp.address), order.deliveryAddress ?? tr(TextApp.not_specified)),
                    _buildDetailRow(tr(TextApp.phone_number), order.phoneNumber ?? tr(TextApp.not_specified)),
                  ]),
                  SizedBox(height: 20),
                  _buildItemsSection(order.items ?? []),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getBoldStyle(
            fontSize: 16,
            // fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: getBoldStyle(
              // fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: getBoldStyle(color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection(List<OrderItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${tr(TextApp.products)} (${items.length})',
          style: getBoldStyle(
            fontSize: 16,
            // fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 12),
        ...items.map((item) => _buildItemCard(item)).toList(),
      ],
    );
  }

  Widget _buildItemCard(OrderItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.image ?? '',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 60,
                height: 60,
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
                  item.name ?? tr(TextApp.not_specified),
                  style: getBoldStyle(
                    // fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${tr(TextApp.quantity)}: ${item.quantity}',
                  style: getBoldStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${item.price} ${tr(TextApp.AED)}',
            style: getBoldStyle(
              // fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }
}

// Sample models (replace with your actual models)
class Order {
  final String? id;
  final String? status;
  final String? createdAt;
  final double? totalAmount;
  final String? deliveryAddress;
  final String? phoneNumber;
  final List<OrderItem>? items;

  Order({
    this.id,
    this.status,
    this.createdAt,
    this.totalAmount,
    this.deliveryAddress,
    this.phoneNumber,
    this.items,
  });
}

class OrderItem {
  final String? name;
  final String? image;
  final int? quantity;
  final double? price;

  OrderItem({
    this.name,
    this.image,
    this.quantity,
    this.price,
  });
}