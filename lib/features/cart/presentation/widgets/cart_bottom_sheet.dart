import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/shared/buttons/custombutton.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';

class CartBottomSheet extends StatelessWidget {
  final double totalPrice;
  final double discount;
  final double finalPrice;
  final VoidCallback? onCheckout;
  final Color? labelColor;
  final Color? valueColor;
  final Color? discountColor;
  final Color? backgroundColor;

  const CartBottomSheet({
    super.key,
    required this.totalPrice,
    required this.discount,
    required this.finalPrice,
    this.onCheckout,
    this.labelColor,
    this.valueColor,
    this.discountColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 0.23.sh,
      padding: AppSizes.paddingAllMd,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radiusLg),
          topRight: Radius.circular(AppSizes.radiusLg),
        ),
      ),
      child: Column(
        children: [
          _summaryRow("Total Price", totalPrice),
          _summaryRow(
            "Discount",
            -discount,
            colorOverride: discountColor ?? Colors.red,
          ),
          Divider(thickness: 0.5, height: 10.h),
          _summaryRow("Final Price", finalPrice, isBold: true),
          SizedBox(height: 12.h),
          CustomButton(
            ontap:
                onCheckout ??
                () {
                  showCustomSnackbar(
                    context: context,
                    message: 'Checkout is not implemented yet.',
                    type: SnackbarType.error,
                  );
                },
            textColor: Colors.white,
            backgroundColor: colorScheme.primary,
            text: 'Proceed to CheckOut',
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    double amount, {
    bool isBold = false,
    Color? colorOverride,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: labelColor ?? Colors.black,
            ),
          ),
          Text(
            "₹${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: colorOverride ?? valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
