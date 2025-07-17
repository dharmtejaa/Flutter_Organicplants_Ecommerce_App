import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/features/profile/presentation/screens/addresses_screen.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/features/cart/data/cart_items_quantity_model.dart';
import 'package:provider/provider.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'package:organicplants/features/profile/presentation/screens/order_history_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final AllPlantsModel? buyNowPlant;
  final List<CartItem>? cartItems;
  final double? totalOriginalPrice;
  final double? totalOfferPrice;
  final double? totalDiscount;
  const CheckoutScreen({
    super.key,
    this.buyNowPlant,
    this.cartItems,
    this.totalOriginalPrice,
    this.totalOfferPrice,
    this.totalDiscount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final List<Map<String, dynamic>> cartItems;

  final Map<String, String> address = {
    'name': 'John Doe',
    'address': '123 Green Street, Garden Colony, Mumbai, 400001',
    'phone': '+91 98765 43210',
  };

  // Refactor selectedPayment to ValueNotifier
  final ValueNotifier<String> selectedPayment = ValueNotifier('');
  final List<String> paymentMethods = [
    'Cash on Delivery',
    'UPI',
    'Credit/Debit Card',
  ];

  final ValueNotifier<bool> isPlacingOrder = ValueNotifier(false);

  int get totalPrice =>
      widget.totalOfferPrice?.toInt() ??
      cartItems.fold(
        0,
        (sum, item) =>
            sum + ((item['price'] as int) * (item['quantity'] as int)),
      );

  @override
  void initState() {
    super.initState();
    if (widget.buyNowPlant != null) {
      final plant = widget.buyNowPlant!;
      cartItems = [
        {
          'image':
              (plant.images != null && plant.images!.isNotEmpty)
                  ? plant.images!.first.url
                  : 'assets/No_Plant_Found.png',
          'name': plant.commonName ?? 'Unknown Plant',
          'quantity': 1,
          'price': plant.prices?.offerPrice?.toInt() ?? 0,
        },
      ];
    } else if (widget.cartItems != null) {
      cartItems =
          widget.cartItems!
              // ignore: unnecessary_null_comparison
              .where((item) => item != null)
              .map(
                (item) => {
                  'image':
                      (item.plant.images != null &&
                              item.plant.images!.isNotEmpty)
                          ? item.plant.images!.first.url
                          : 'assets/No_Plant_Found.png',
                  'name': item.plant.commonName ?? 'Unknown Plant',
                  'quantity': item.quantity,
                  'price': item.plant.prices?.offerPrice?.toInt() ?? 0,
                },
              )
              .toList();
    } else {
      cartItems = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cart Summary
              Text(
                'Order Summary',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),
              _buildCartSummary(colorScheme),
              SizedBox(height: 16.h),

              // Delivery Address
              _buildSectionHeader(
                'Delivery Address',
                Icons.location_on,
                colorScheme,
              ),
              _buildAddressCard(colorScheme),
              SizedBox(height: 16.h),

              // Payment Method
              _buildSectionHeader('Payment Method', Icons.payment, colorScheme),
              _buildPaymentMethods(colorScheme),
              SizedBox(height: 16.h),

              // Total and Place Order
              _buildTotalAndButton(colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartSummary(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cartItems.length,
        separatorBuilder:
            (_, __) =>
            // ignore: deprecated_member_use
            Divider(height: 1, color: colorScheme.outline.withOpacity(0.2)),
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            leading: SizedBox(
              width: 44.w,
              height: 44.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(item['image'], fit: BoxFit.cover),
              ),
            ),
            title: Text(
              item['name'],
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('Qty: ${item['quantity']}'),
            trailing: Text(
              '₹${item['price'] * item['quantity']}',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    IconData icon,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary, size: 18.r),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.home, color: colorScheme.primary, size: 24.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address['name']!,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.h),
                Text(
                  address['address']!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  address['phone']!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressesScreen()),
              );
            },
            child: Text('Change', style: TextStyle(color: colorScheme.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(ColorScheme colorScheme) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedPayment,
      builder: (context, payment, _) {
        return Column(
          children:
              paymentMethods.map((method) {
                return RadioListTile<String>(
                  value: method,
                  groupValue: payment,
                  onChanged: (value) {
                    if (value != null) selectedPayment.value = value;
                  },
                  title: Text(method),
                  activeColor: colorScheme.primary,
                );
              }).toList(),
        );
      },
    );
  }

  Widget _buildTotalAndButton(ColorScheme colorScheme) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            Text(
              '₹$totalPrice',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ValueListenableBuilder<bool>(
          valueListenable: isPlacingOrder,
          builder: (context, placing, _) {
            if (placing) {
              return SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.onPrimary,
                  ),
                ),
              );
            } else {
              return SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  void _placeOrder() async {
    isPlacingOrder.value = true;
    await Future.delayed(Duration(seconds: 2));
    isPlacingOrder.value = false;
    if (mounted) {
      // Add order to ProfileProvider
      final order = {
        'id': 'ORD${DateTime.now().millisecondsSinceEpoch}',
        'date': DateTime.now().toString().substring(0, 10),
        'status': 'In Transit',
        'total': '₹$totalPrice',
        'items':
            cartItems
                .map(
                  (item) => {
                    'name': item['name'],
                    'quantity': item['quantity'],
                    'price': '₹${item['price']}',
                  },
                )
                .toList(),
        'deliveryAddress': address['address'],
        'trackingNumber': null,
      };
      Provider.of<ProfileProvider>(context, listen: false).addOrder(order);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Order placed successfully!')));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
        (route) => route.isFirst,
      );
    }
  }
}
