import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/features/product/presentation/screens/product_screen.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:collection/collection.dart';
import 'track_orders_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Order Details',
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${order['id']}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Placed on ${order['date']}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          'Status: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        _buildStatusChip(order['status'], colorScheme),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Product List
            Text(
              'Products',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            ...List.generate(order['items'].length, (index) {
              final item = order['items'][index];
              return GestureDetector(
                onTap: () {
                  // Try to find the plant by id or name
                  final plant = allPlantsGlobal.firstWhereOrNull(
                    (p) => p.id == item['id'] || p.commonName == item['name'],
                  );
                  if (plant != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(plants: plant),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product details not found.')),
                    );
                  }
                },
                child: Card(
                  margin: EdgeInsets.only(bottom: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product image
                        Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child:
                              item['image'] != null &&
                                      item['image'].toString().isNotEmpty
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.network(
                                      item['image'],
                                      fit: BoxFit.cover,
                                      width: 56.w,
                                      height: 56.w,
                                    ),
                                  )
                                  : (() {
                                    final plant = allPlantsGlobal
                                        .firstWhereOrNull(
                                          (p) =>
                                              p.id == item['id'] ||
                                              p.commonName == item['name'],
                                        );
                                    if (plant != null &&
                                        plant.images != null &&
                                        plant.images!.isNotEmpty) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        child: Image.network(
                                          plant.images!.first.url ?? '',
                                          fit: BoxFit.cover,
                                          width: 56.w,
                                          height: 56.w,
                                        ),
                                      );
                                    }
                                    return Icon(
                                      Icons.local_florist,
                                      size: 32.r,
                                      color: colorScheme.primary,
                                    );
                                  })(),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Qty: ${item['quantity']}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                item['price'],
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 16.h),
            // Order Total
            Row(
              children: [
                Text(
                  'Order Total:',
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
            SizedBox(height: 24.h),
            // Delivery Info (if available)
            if (order['deliveryAddress'] != null) ...[
              Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                order['deliveryAddress'],
                style: TextStyle(
                  fontSize: 14.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 16.h),
            ],
            if (order['estimatedDelivery'] != null) ...[
              Text(
                'Estimated Delivery',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                order['estimatedDelivery'],
                style: TextStyle(
                  fontSize: 14.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (order['trackingNumber'] != null) ...[
              SizedBox(height: 32.h),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.local_shipping_outlined),
                  label: Text('Track Order'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 14.h,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrackOrdersScreen(order: order),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, ColorScheme colorScheme) {
    Color backgroundColor;
    Color textColor;
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
