import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/my_custom_cache_manager.dart';
import 'package:organicplants/core/theme/app_shadows.dart';
import 'package:organicplants/features/cart/data/cart_model.dart';
import 'package:organicplants/features/profile/presentation/screens/addresses_screen.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:provider/provider.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'package:organicplants/features/profile/presentation/screens/order_history_screen.dart';
import 'package:lottie/lottie.dart';

class CheckoutScreen extends StatefulWidget {
  final String? buyNowPlantId;
  final List<CartItemModel>? cartItems;
  final double? totalOriginalPrice;
  final double? totalOfferPrice;
  final double? totalDiscount;
  const CheckoutScreen({
    super.key,
    this.buyNowPlantId,
    this.cartItems,
    this.totalOriginalPrice,
    this.totalOfferPrice,
    this.totalDiscount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final List<CartItemModel> cartItems;

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
        (sum, item) => sum + ((item.offerPrice.toInt()) * (item.quantity)),
      );

  @override
  void initState() {
    super.initState();
    if (widget.buyNowPlantId != null) {
      final AllPlantsModel? plant = AllPlantsGlobalData.getById(
        widget.buyNowPlantId ?? '',
      );
      if (plant != null) {
        cartItems = [
          CartItemModel(
            plantId: plant.id ?? '',
            plantName: plant.commonName ?? '',
            imageUrl:
                plant.images?.isNotEmpty == true
                    ? plant.images?.first.url ?? ''
                    : '',
            originalPrice: (plant.prices?.originalPrice ?? 0).toDouble(),
            offerPrice: (plant.prices?.offerPrice ?? 0).toDouble(),
            discount: 0.0,
            rating: (plant.rating ?? 0).toDouble(),
            quantity: 1,
          ),
        ];
      } else {
        cartItems = [];
      }
    } else if (widget.cartItems != null) {
      cartItems = widget.cartItems!;
    } else {
      cartItems = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: textTheme.headlineMedium),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.radiusSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart Summary
                Text('Order Summary', style: textTheme.headlineSmall),
                SizedBox(height: 10.h),
                _buildCartSummary(colorScheme, textTheme),
                SizedBox(height: 16.h),
                // Delivery Address
                _buildSectionHeader(
                  textTheme,
                  'Delivery Address',
                  Icons.location_on,
                  colorScheme,
                ),
                _buildAddressCard(colorScheme, textTheme),
                SizedBox(height: 16.h),
                // Payment Method
                _buildSectionHeader(
                  textTheme,
                  'Payment Method',
                  Icons.payment,
                  colorScheme,
                ),
                _buildPaymentMethods(colorScheme, textTheme),
                SizedBox(height: 20.h),
                // Total and Place Order
                _buildTotalAndButton(colorScheme, textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartSummary(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        boxShadow: AppShadows.cardShadow(context),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              child: CachedNetworkImage(
                height: 45.h,
                width: 45.w,
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                cacheManager: MyCustomCacheManager.instance,
              ),
            ),
            title: Text(item.plantName, style: textTheme.titleMedium),
            subtitle: Text(
              'Qty: ${item.quantity}',
              style: textTheme.bodyMedium,
            ),
            trailing: Text(
              '₹${item.offerPrice.toInt() * item.quantity}',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(
    TextTheme textTheme,
    String title,
    IconData icon,
    ColorScheme colorScheme,
  ) {
    return Row(
      children: [
        Icon(icon, color: colorScheme.primary, size: AppSizes.iconSm),
        SizedBox(width: AppSizes.radiusSm),
        Text(title, style: textTheme.titleLarge),
      ],
    );
  }

  Widget _buildAddressCard(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      padding: AppSizes.paddingAllSm,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        boxShadow: AppShadows.cardShadow(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.home, color: colorScheme.primary, size: AppSizes.iconSm),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address['name'] ?? '', style: textTheme.titleMedium),
                SizedBox(height: 3.h),
                Text(address['address'] ?? '', style: textTheme.bodySmall),
                SizedBox(height: 3.h),
                Text(address['phone'] ?? '', style: textTheme.bodySmall),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressesScreen()),
              );
            },
            icon: Icon(
              Icons.edit,
              color: colorScheme.primary,
              size: AppSizes.iconSm,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(ColorScheme colorScheme, TextTheme textTheme) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedPayment,
      builder: (context, payment, _) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
          padding: AppSizes.paddingAllSm,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            boxShadow: AppShadows.cardShadow(context),
          ),
          child: Column(
            children:
                paymentMethods.map((method) {
                  return RadioListTile<String>(
                    value: method,
                    groupValue: payment,
                    onChanged: (value) {
                      if (value != null) selectedPayment.value = value;
                    },
                    title: Text(method, style: textTheme.bodyMedium),
                    activeColor: colorScheme.primary,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildTotalAndButton(ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingSm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '₹$totalPrice',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        ValueListenableBuilder<bool>(
          valueListenable: isPlacingOrder,
          builder: (context, placing, _) {
            if (placing) {
              return SizedBox(
                width: 25.w,
                height: 25.w,
                child: CircularProgressIndicator(
                  strokeWidth: 3.w,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                ),
              );
            } else {
              return ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(minimumSize: Size(350.w, 48.h)),
                child: Text('Place Order'),
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
                    'name': item.plantName,
                    'quantity': item.quantity,
                    'price': '₹${item.offerPrice.toInt()}',
                  },
                )
                .toList(),
        'deliveryAddress': address['address'] ?? '',
        'trackingNumber': null,
      };
      final textTheme = Theme.of(context).textTheme;
      final colorScheme = Theme.of(context).colorScheme;
      Provider.of<ProfileProvider>(context, listen: false).addOrder(order);
      // Show payment success dialog with animation
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => Dialog(
              backgroundColor: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              ),
              child: Padding(
                padding: AppSizes.paddingAllSm,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.network(
                      //width: 320.w,
                      height: 220.h,
                      'https://res.cloudinary.com/daqvdhmw8/raw/upload/v1753080800/successful_toc6py.json', // Use your confetti/sprinkle animation here
                      repeat: false,
                    ),
                    //SizedBox(height: 16),
                    Text(
                      'Payment Successful!',
                      style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Your order has been placed successfully.',
                      style: textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(10.w, 10.h),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
      );
      //CustomSnackBar.showSuccess(context, 'Order placed successfully!');
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
        (route) => route.isFirst,
      );
    }
  }
}
