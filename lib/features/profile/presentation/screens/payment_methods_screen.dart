import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': '1',
      'type': 'Credit Card',
      'name': 'Visa ending in 1234',
      'icon': Icons.credit_card,
      'color': Colors.blue,
      'isDefault': true,
      'expiry': '12/25',
    },
    {
      'id': '2',
      'type': 'UPI',
      'name': 'john.doe@okicici',
      'icon': Icons.account_balance_wallet,
      'color': Colors.purple,
      'isDefault': false,
    },
    {
      'id': '3',
      'type': 'Net Banking',
      'name': 'HDFC Bank',
      'icon': Icons.account_balance,
      'color': Colors.green,
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Payment Methods",
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
      body: Column(
        children: [
          Expanded(
            child:
                _paymentMethods.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: _paymentMethods.length,
                      itemBuilder: (context, index) {
                        return _buildPaymentMethodCard(_paymentMethods[index]);
                      },
                    ),
          ),
          _buildAddPaymentMethodButton(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.payment_outlined, size: 80.r, color: colorScheme.outline),
          SizedBox(height: 16.h),
          Text(
            "No Payment Methods",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Add a payment method to make purchases",
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

  Widget _buildPaymentMethodCard(Map<String, dynamic> paymentMethod) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: paymentMethod['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                paymentMethod['icon'],
                color: paymentMethod['color'],
                size: 24.r,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        paymentMethod['type'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      if (paymentMethod['isDefault']) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Default',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    paymentMethod['name'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (paymentMethod['expiry'] != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      'Expires: ${paymentMethod['expiry']}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: colorScheme.onSurfaceVariant),
              onSelected:
                  (value) => _handlePaymentMethodAction(value, paymentMethod),
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 'set_default',
                      child: Row(
                        children: [
                          Icon(Icons.star_outline, size: 20.r),
                          SizedBox(width: 8.w),
                          Text('Set as Default'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined, size: 20.r),
                          SizedBox(width: 8.w),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 20.r,
                          ),
                          SizedBox(width: 8.w),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddPaymentMethodButton() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      child: ElevatedButton(
        onPressed: _showAddPaymentMethodDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 20.r),
            SizedBox(width: 8.w),
            Text(
              'Add Payment Method',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePaymentMethodAction(
    String action,
    Map<String, dynamic> paymentMethod,
  ) {
    switch (action) {
      case 'set_default':
        _setDefaultPaymentMethod(paymentMethod);
        break;
      case 'edit':
        _editPaymentMethod(paymentMethod);
        break;
      case 'delete':
        _deletePaymentMethod(paymentMethod);
        break;
    }
  }

  void _showAddPaymentMethodDialog() {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Add Payment Method',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPaymentOption(
                  context,
                  'Credit/Debit Card',
                  Icons.credit_card,
                  Colors.blue,
                  () => _addCreditCard(),
                ),
                _buildPaymentOption(
                  context,
                  'UPI',
                  Icons.account_balance_wallet,
                  Colors.purple,
                  () => _addUPI(),
                ),
                _buildPaymentOption(
                  context,
                  'Net Banking',
                  Icons.account_balance,
                  Colors.green,
                  () => _addNetBanking(),
                ),
                _buildPaymentOption(
                  context,
                  'Digital Wallet',
                  Icons.phone_android,
                  Colors.orange,
                  () => _addDigitalWallet(),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: color, size: 24.r),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void _addCreditCard() {
    // TODO: Navigate to credit card form
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Credit card form coming soon!')));
  }

  void _addUPI() {
    // TODO: Navigate to UPI form
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('UPI form coming soon!')));
  }

  void _addNetBanking() {
    // TODO: Navigate to net banking form
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Net banking form coming soon!')));
  }

  void _addDigitalWallet() {
    // TODO: Navigate to digital wallet form
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Digital wallet form coming soon!')));
  }

  void _setDefaultPaymentMethod(Map<String, dynamic> paymentMethod) {
    setState(() {
      for (var method in _paymentMethods) {
        method['isDefault'] = method['id'] == paymentMethod['id'];
      }
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Default payment method updated!')));
  }

  void _editPaymentMethod(Map<String, dynamic> paymentMethod) {
    // TODO: Navigate to edit payment method screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit payment method feature coming soon!')),
    );
  }

  void _deletePaymentMethod(Map<String, dynamic> paymentMethod) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Delete Payment Method',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.error,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this payment method?',
              style: TextStyle(fontSize: 16.sp, color: colorScheme.onSurface),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _paymentMethods.removeWhere(
                      (method) => method['id'] == paymentMethod['id'],
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Payment method deleted successfully!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onError,
                ),
                child: Text(
                  'Delete',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
    );
  }
}
