import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackOrdersScreen extends StatefulWidget {
  final Map<String, dynamic>? order;
  const TrackOrdersScreen({super.key, this.order});

  @override
  State<TrackOrdersScreen> createState() => _TrackOrdersScreenState();
}

class _TrackOrdersScreenState extends State<TrackOrdersScreen> {
  final List<Map<String, dynamic>> _activeOrders = [
    {
      'id': 'ORD004',
      'date': '2024-01-20',
      'status': 'In Transit',
      'total': '₹1,599',
      'items': [
        {'name': 'Monstera Deliciosa', 'quantity': 1, 'price': '₹899'},
        {'name': 'Plant Pot', 'quantity': 1, 'price': '₹400'},
        {'name': 'Fertilizer Pack', 'quantity': 1, 'price': '₹300'},
      ],
      'deliveryAddress': '123 Green Street, Garden Colony, Mumbai - 400001',
      'trackingNumber': 'TRK123456789',
      'estimatedDelivery': '2024-01-25',
      'currentLocation': 'Mumbai Hub',
      'progress': 0.7,
    },
    {
      'id': 'ORD005',
      'date': '2024-01-18',
      'status': 'Processing',
      'total': '₹2,199',
      'items': [
        {'name': 'Snake Plant', 'quantity': 2, 'price': '₹1,099'},
      ],
      'deliveryAddress': '456 Business Park, Tech Hub, Mumbai - 400002',
      'trackingNumber': 'TRK987654321',
      'estimatedDelivery': '2024-01-28',
      'currentLocation': 'Processing Center',
      'progress': 0.3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final ordersToShow = widget.order != null ? [widget.order!] : _activeOrders;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Track Orders",
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
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: colorScheme.onSurface),
            onPressed: _refreshOrders,
          ),
        ],
      ),
      body:
          ordersToShow.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: ordersToShow.length,
                itemBuilder: (context, index) {
                  return _buildOrderTrackingCard(ordersToShow[index]);
                },
              ),
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_shipping_outlined,
              size: 64.r,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "No Active Orders",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "You don't have any orders in progress right now",
            style: TextStyle(
              fontSize: 16.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Navigate to store
            },
            icon: Icon(Icons.shopping_bag_outlined),
            label: Text("Start Shopping"),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTrackingCard(Map<String, dynamic> order) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: 20.h),
      elevation: 4,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    order['status'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(order['status']),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "Order #${order['id']}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "${(order['progress'] * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                LinearProgressIndicator(
                  value: order['progress'],
                  backgroundColor: colorScheme.outline.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                  minHeight: 8.h,
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Order Items
            Text(
              "Items",
              style: TextStyle(
                fontSize: 16.sp,
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

            // Delivery Info
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20.r,
                        color: colorScheme.primary,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Delivery Address",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
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
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        size: 20.r,
                        color: colorScheme.primary,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Estimated Delivery",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
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
              ),
            ),

            SizedBox(height: 16.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _viewOrderDetails(order),
                    icon: Icon(Icons.visibility_outlined, size: 18.r),
                    label: Text("View Details"),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colorScheme.primary),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      foregroundColor: colorScheme.primary, // Explicitly set
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _trackOrder(order),
                    icon: Icon(Icons.track_changes_outlined, size: 18.r),
                    label: Text("Track"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary, // Explicitly set
                      foregroundColor: colorScheme.onPrimary, // Explicitly set
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return Colors.orange;
      case 'in transit':
        return Colors.blue;
      case 'out for delivery':
        return Colors.green;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _refreshOrders() {
    setState(() {
      // TODO: Refresh orders from API
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Orders refreshed!')));
  }

  void _viewOrderDetails(Map<String, dynamic> order) {
    // TODO: Navigate to order details screen
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Viewing order details...')));
  }

  void _trackOrder(Map<String, dynamic> order) {
    // TODO: Navigate to detailed tracking screen
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Opening detailed tracking...')));
  }
}
