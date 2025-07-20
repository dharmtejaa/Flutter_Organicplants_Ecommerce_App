// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/features/product/presentation/screens/product_screen.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'order_details_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/shared/widgets/custom_dialog.dart';
import 'package:organicplants/core/theme/app_shadows.dart';
import 'package:organicplants/core/services/app_sizes.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  static final List<String> _tabs = [
    'All',
    'Delivered',
    'In Transit',
    'Cancelled',
    'Returned',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final orders = Provider.of<ProfileProvider>(context).orders;

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: colorScheme.surfaceContainerLowest,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Order History", style: textTheme.headlineMedium),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorScheme.onSurface,
              size: AppSizes.iconMd,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(56.h),
            child: Container(
              height: 56.h,
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
                  return _buildEmptyState(context);
                }
                return ListView.builder(
                  padding: AppSizes.paddingAllMd,
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(context, filteredOrders[index]);
                  },
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
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
          SizedBox(height: AppSizes.spaceHeightMd),
          Text(
            "No Orders Found",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: AppSizes.spaceHeightMd),
          Text(
            "Start shopping to see your order history here",
            style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSizes.spaceHeightMd),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EntryScreen()),
              );
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

  Widget _buildOrderCard(BuildContext context, Map<String, dynamic> order) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.only(bottom: 20.h),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        // ignore: deprecated_member_use
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
                _buildStatusChip(context, order['status'], prominent: true),
              ],
            ),
            SizedBox(height: 10.h),
            // ignore: deprecated_member_use
            Divider(thickness: 1, color: colorScheme.outline.withOpacity(0.08)),
            SizedBox(height: 10.h),
            // Product Thumbnails
            _buildProductThumbnails(context, order),

            SizedBox(height: 16.h),

            // Order Items
            Text(
              "Items",
              style: TextStyle(
                fontSize: 14,
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
                            fontSize: 14,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Qty: ${item['quantity']}",
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(width: AppSizes.spaceMd),
                        Text(
                          item['price'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),

            SizedBox(height: AppSizes.spaceHeightMd),

            // Order Total
            Row(
              children: [
                Text(
                  "Total: ₹${order['total']}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                Spacer(),
                Text(
                  "₹${order['total']}",
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
                    onPressed: () => _viewOrderDetails(context, order),
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
                      onPressed: () => _reorder(context, order),
                      icon: Icon(
                        Icons.shopping_bag,
                        color: colorScheme.onPrimary,
                      ),
                      label: Text("Reorder", style: textTheme.labelLarge),
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
                            // ignore: use_build_context_synchronously
                            context,
                            listen: false,
                          ).cancelOrder(order['id']);
                        }
                      },
                      icon: Icon(Icons.cancel, color: colorScheme.onPrimary),
                      label: Text(
                        "Cancel Order",
                        style: textTheme.labelLarge,
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

  Widget _buildStatusChip(
    BuildContext context,
    String status, {
    bool prominent = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    Color backgroundColor;
    Color textColor;
    double fontSize = prominent ? 14 : 12;
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
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
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

  Widget _buildProductThumbnails(
    BuildContext context,
    Map<String, dynamic> order,
  ) {
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
              margin: EdgeInsets.only(right: AppSizes.spaceMd),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                border: Border.all(
                  color: colorScheme.outline.withOpacity(0.15),
                ),
                color: colorScheme.surfaceContainerHighest,
              ),
              child:
                  items[i]['image'] != null &&
                          items[i]['image'].toString().isNotEmpty
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        child: Image.network(
                          items[i]['image'],
                          fit: BoxFit.cover,
                          width: 44,
                          height: 44,
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
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              color: colorScheme.primary.withOpacity(0.1),
            ),
            child: Text(
              "+${items.length - maxThumbs} more",
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  void _viewOrderDetails(BuildContext context, Map<String, dynamic> order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailsScreen(order: order)),
    );
  }

  void _reorder(BuildContext context, Map<String, dynamic> order) {
    CustomSnackBar.showSuccess(context, "Items added to cart for reorder!");
  }
}
