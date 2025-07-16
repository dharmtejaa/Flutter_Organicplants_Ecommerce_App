import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/features/product/presentation/screens/product_screen.dart';
import 'package:provider/provider.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'order_details_screen.dart';

import 'package:collection/collection.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/shared/widgets/custom_dialog.dart';
import 'package:organicplants/core/theme/app_shadows.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = [
    'All',
    'Delivered',
    'In Transit',
    'Cancelled',
    'Returned',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final orders = Provider.of<ProfileProvider>(context).orders;

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: colorScheme.surfaceContainerLowest,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Order History",
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: Container(
              height: 56,
              alignment: Alignment.centerLeft,
              child: TabBar(
                isScrollable: true,
                indicatorColor: colorScheme.primary,
                labelColor: colorScheme.primary,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(fontSize: 16),
                tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children:
              _tabs.map((tab) {
                List<Map<String, dynamic>> filteredOrders;
                if (tab == 'All') {
                  filteredOrders = orders;
                } else {
                  filteredOrders =
                      orders.where((order) => order['status'] == tab).toList();
                }
                if (filteredOrders.isEmpty) {
                  return _buildEmptyState();
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(filteredOrders[index]);
                  },
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80.r,
            color: colorScheme.outline,
          ),
          SizedBox(height: 16.h),
          Text(
            "No Orders Found",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Start shopping to see your order history here",
            style: TextStyle(
              fontSize: 16.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Navigate to store
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            child: Text("Start Shopping"),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: 20.h),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.08)),
      ),
      child: Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${order['id']}",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Placed on ${order['date']}",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(order['status'], prominent: true),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(thickness: 1, color: colorScheme.outline.withOpacity(0.08)),
            SizedBox(height: 10.h),
            // Product Thumbnails
            _buildProductThumbnails(order),

            SizedBox(height: 16.h),

            // Order Items
            Text(
              "Items",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),

            ...order['items']
                .map<Widget>(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      children: [
                        Text(
                          "• ${item['name']}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Qty: ${item['quantity']}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          item['price'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),

            SizedBox(height: 16.h),

            // Order Total
            Row(
              children: [
                Text(
                  "Total:",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                Spacer(),
                Text(
                  order['total'],
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _viewOrderDetails(order),
                    icon: Icon(Icons.receipt_long, color: colorScheme.primary),
                    label: Text(
                      "View Details",
                      style: TextStyle(color: colorScheme.primary),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colorScheme.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                if (order['status'] == 'Delivered')
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _reorder(order),
                      icon: Icon(
                        Icons.shopping_bag,
                        color: colorScheme.onPrimary,
                      ),
                      label: Text("Reorder"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
                if (order['status'] != 'Cancelled' &&
                    order['status'] != 'Delivered')
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final confirm = await CustomDialog.showConfirmation(
                          context: context,
                          title: 'Cancel Order',
                          content:
                              'Are you sure you want to cancel this order? This action cannot be undone.',
                          confirmText: 'Yes, Cancel',
                          cancelText: 'No, Keep Order',
                          icon: Icons.cancel_outlined,
                          iconColor: Colors.red,
                        );
                        if (confirm == true) {
                          Provider.of<ProfileProvider>(
                            context,
                            listen: false,
                          ).cancelOrder(order['id']);
                        }
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      label: Text(
                        "Cancel Order",
                        style: Theme.of(context).textTheme.labelLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, {bool prominent = false}) {
    final colorScheme = Theme.of(context).colorScheme;
    Color backgroundColor;
    Color textColor;
    double fontSize = prominent ? 14.sp : 12.sp;
    FontWeight fontWeight = prominent ? FontWeight.bold : FontWeight.w600;
    EdgeInsets padding =
        prominent
            ? EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h)
            : EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h);
    switch (status.toLowerCase()) {
      case 'delivered':
        backgroundColor = Colors.green;
        textColor = Colors.white;
        break;
      case 'in transit':
        backgroundColor = Colors.blue;
        textColor = Colors.white;
        break;
      case 'cancelled':
        backgroundColor = Colors.red;
        textColor = Colors.white;
        break;
      case 'returned':
        backgroundColor = Colors.orange;
        textColor = Colors.white;
        break;
      default:
        backgroundColor = colorScheme.outline;
        textColor = colorScheme.onSurface;
    }
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: prominent ? AppShadows.elevatedShadow(context) : [],
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildProductThumbnails(Map<String, dynamic> order) {
    final colorScheme = Theme.of(context).colorScheme;
    final items = order['items'] as List;
    final int maxThumbs = 3;
    return Row(
      children: [
        ...List.generate(
          items.length > maxThumbs ? maxThumbs : items.length,
          (i) => GestureDetector(
            onTap: () {
              final plant = allPlantsGlobal.firstWhereOrNull(
                (p) =>
                    p.id == items[i]['id'] || p.commonName == items[i]['name'],
              );
              if (plant != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductScreen(plants: plant),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Product details not found.')),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: colorScheme.outline.withOpacity(0.15),
                ),
                color: colorScheme.surfaceContainerHighest,
              ),
              child:
                  items[i]['image'] != null &&
                          items[i]['image'].toString().isNotEmpty
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          items[i]['image'],
                          fit: BoxFit.cover,
                          width: 44.w,
                          height: 44.w,
                        ),
                      )
                      : Icon(
                        Icons.local_florist,
                        color: colorScheme.primary,
                        size: 28,
                      ),
            ),
          ),
        ),
        if (items.length > maxThumbs)
          Container(
            width: 44.w,
            height: 44.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: colorScheme.primary.withOpacity(0.1),
            ),
            child: Text(
              "+${items.length - maxThumbs} more",
              style: TextStyle(
                fontSize: 13.sp,
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  void _viewOrderDetails(Map<String, dynamic> order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailsScreen(order: order)),
    );
  }

  void _reorder(Map<String, dynamic> order) {
    // TODO: Add items to cart and navigate to cart
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Items added to cart for reorder!')));
  }
}
