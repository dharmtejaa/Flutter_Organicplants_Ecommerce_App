import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/features/cart/data/cart_items_quantity_model.dart';
import 'package:organicplants/features/cart/logic/cart_provider.dart';
import 'package:organicplants/features/cart/presentation/widgets/card_tile.dart';
import 'package:organicplants/features/cart/presentation/widgets/cart_bottom_sheet.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/features/cart/presentation/screens/checkout_screen.dart';
import 'package:organicplants/shared/buttons/searchbutton.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:organicplants/shared/widgets/no_result_found.dart';
import 'package:provider/provider.dart';

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EntryScreen()),
            );
          },
          icon: Icon(
            Icons.arrow_back_sharp,
            color: colorScheme.onSurface,
            size: AppSizes.iconMd,
          ),
        ),
        title: Text("My cart", style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        actions: [
          SearchButton(),
          WishlistIconWithBadge(),
          SizedBox(width: 10.w),
        ],
      ),

      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          return cartItems.isEmpty
              ? Center(
                child: NoResultFound(
                  title: "Your cart is empty",
                  subtitle: "Add some plants to get started!",
                  icon: Icons.shopping_cart_outlined,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CheckoutScreen(
                            cartItems: cartItems,
                            totalOriginalPrice: cartProvider.totalOriginalPrice,
                            totalOfferPrice: cartProvider.totalOfferPrice,
                            totalDiscount: cartProvider.totalDiscount,
                          ),
                    ),
                  );
                },
              )
              : null,
    );
  }
}
