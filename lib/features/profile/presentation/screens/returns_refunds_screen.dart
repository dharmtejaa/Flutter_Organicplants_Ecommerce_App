// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/shared/widgets/custom_dialog.dart';

class ReturnsRefundsScreen extends StatefulWidget {
  const ReturnsRefundsScreen({super.key});

  @override
  State<ReturnsRefundsScreen> createState() => _ReturnsRefundsScreenState();
}

class _ReturnsRefundsScreenState extends State<ReturnsRefundsScreen> {
  // Refactor return items to ValueNotifier
  final ValueNotifier<List<Map<String, dynamic>>> _returnItems = ValueNotifier(
    [],
  );

  @override
  void initState() {
    super.initState();
    // Initialize _returnItems with your data
    _returnItems.value = [
      {
        'id': 'RET001',
        'orderId': 'ORD003',
        'date': '2024-01-10',
        'status': 'Refunded',
        'reason': 'Damaged during delivery',
        'items': [
          {'name': 'Peace Lily', 'quantity': 1, 'price': '₹899'},
        ],
        'refundAmount': '₹899',
        'refundMethod': 'Original Payment Method',
      },
      {
        'id': 'RET002',
        'orderId': 'ORD002',
        'date': '2024-01-05',
        'status': 'Processing',
        'reason': 'Wrong item received',
        'items': [
          {'name': 'Snake Plant', 'quantity': 1, 'price': '₹1,099'},
        ],
        'refundAmount': '₹1,099',
        'refundMethod': 'Store Credit',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Returns & Refunds",
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
       
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: colorScheme.onSurface),
            onPressed: _requestReturn,
          ),
        ],
      ),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: _returnItems,
        builder: (context, returnItems, _) {
          return Column(
            children: [
              // Header Section
              Container(
                margin: EdgeInsets.all(16.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primaryContainer,
                      colorScheme.secondaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimaryContainer.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.assignment_return_outlined,
                        color: colorScheme.onPrimaryContainer,
                        size: 24.r,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Return Policy",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "30-day return window for all plants",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Returns List
              Expanded(
                child:
                    returnItems.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: returnItems.length,
                          itemBuilder: (context, index) {
                            return _buildReturnCard(returnItems[index]);
                          },
                        ),
              ),
            ],
          );
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
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.assignment_return_outlined,
              size: 64.r,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "No Returns Yet",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "You haven't made any returns yet",
            style: TextStyle(
              fontSize: 16.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReturnCard(Map<String, dynamic> returnItem) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 3,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Return Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      returnItem['status'],
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    returnItem['status'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(returnItem['status']),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "Return #${returnItem['id']}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Return Details
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
                        Icons.info_outline,
                        size: 20.r,
                        color: colorScheme.primary,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Return Reason",
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
                    returnItem['reason'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Icon(
                        Icons.payment_outlined,
                        size: 20.r,
                        color: colorScheme.primary,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Refund Method",
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
                    returnItem['refundMethod'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Items
            Text(
              "Returned Items",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),

            ...returnItem['items']
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

            // Refund Amount
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: colorScheme.onPrimaryContainer,
                    size: 24.r,
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Refund Amount",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        returnItem['refundAmount'],
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
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
                    onPressed: () => _viewReturnDetails(returnItem),
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
                if (returnItem['status'] == 'Processing')
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _cancelReturn(returnItem),
                      icon: Icon(Icons.cancel_outlined, size: 18.r),
                      label: Text("Cancel"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.error, // Explicitly set
                        foregroundColor: colorScheme.onError, // Explicitly set
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
      case 'refunded':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _requestReturn() {
   
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Request return feature coming soon!')),
    );
  }

  void _viewReturnDetails(Map<String, dynamic> returnItem) {
    
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Viewing return details...')));
  }

  void _cancelReturn(Map<String, dynamic> returnItem) {
    CustomDialog.showDeleteConfirmation(
      context: context,
      title: 'Cancel Return',
      content:
          'Are you sure you want to cancel this return request? This action cannot be undone.',
      onDelete: () {
        final updated = List<Map<String, dynamic>>.from(_returnItems.value);
        final idx = updated.indexOf(returnItem);
        if (idx != -1) {
          updated[idx] = Map<String, dynamic>.from(updated[idx]);
          updated[idx]['status'] = 'Cancelled';
          _returnItems.value = updated;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Return cancelled successfully!')),
        );
      },
    );
  }
}
