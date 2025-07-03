import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/screens/cart%20screen/views/components/card_tile.dart';
import 'package:organicplants/screens/cart%20screen/views/components/cart_bottom_sheet.dart';
import 'package:organicplants/widgets/components/custom_snackbar.dart';
import 'package:organicplants/widgets/components/no_result_found.dart';
import 'package:organicplants/widgets/components/wishlist_icon_with_badge.dart';
import 'package:organicplants/widgets/customButtons/searchbutton.dart';
import 'package:provider/provider.dart';
import 'package:organicplants/providers/cart_provider.dart';
import 'package:organicplants/models/cart_items_quantity_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.itemList;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp, color: colorScheme.onSurface),
        ),
        title: Text(
          "My Cart",
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: AppSizes.fontXl,
          ),
        ),
        centerTitle: true,
        actions: [SearchButton(), WishlistIconWithBadge()],
      ),

      body: Flexible(
        child: Consumer<CartProvider>(
          builder: (context, value, child) {
            return cartItems.isEmpty
                ? Center(
                  child: NoResultsFound(
                    title: "Your cart is empty",
                    message: "Add some plants to get started!",
                    imagePath: "assets/No_Plant_Found.png",
                  ),
                )
                : Padding(
                  padding: EdgeInsets.only(bottom: 180.h),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    //shrinkWrap: true,
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final CartItem item = cartItems[index];
                      return CardTile(plant: item.plant);
                    },
                  ),
                );
          },
        ),
      ),
      bottomSheet:
          cartItems.isNotEmpty
              ? CartBottomSheet(
                totalPrice: cartProvider.totalOriginalPrice,
                discount: -cartProvider.totalDiscount,
                finalPrice: cartProvider.totalOfferPrice,
                backgroundColor: colorScheme.surface,
                discountColor: AppTheme.offerColor,
                labelColor: colorScheme.onSurface,
                valueColor: colorScheme.onSurface,

                onCheckout: () {
                  showCustomSnackbar(
                    context: context,
                    message: 'Checkout is not implemented yet.',
                    type: SnackbarType.error,
                  );
                },
              )
              : null,
    );
  }
}
