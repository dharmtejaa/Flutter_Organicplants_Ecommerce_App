import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/wishlist/logic/wishlist_provider.dart';
import 'package:organicplants/features/wishlist/presentation/widgets/product_tile.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/widgets/no_result_found.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final wishListProvider = Provider.of<WishlistProvider>(
      context,
      listen: false,
    );
    final wishlistItems = wishListProvider.wishList;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            //size: AppSizes.iconLg,
            color: colorScheme.onSurface,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "My WishList",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          CartIconWithBadge(
            iconColor: colorScheme.onSurface,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Consumer<WishlistProvider>(
        builder: (context, value, child) {
          return wishlistItems.isEmpty
              ? Center(
                child: NoResultsFound(
                  title: "Your Wishlist is empty",
                  message: "Add some plants to get started!",
                  imagePath: "assets/No_Plant_Found.png",
                ),
              )
              : ListView.builder(
                scrollDirection: Axis.vertical,

                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: value.wishList.length,
                itemBuilder: (context, index) {
                  return ProductTile(plant: value.wishList[index]);
                },
              );
        },

        // child: GridView.builder(
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 5,
        //     mainAxisSpacing: 15,
        //     childAspectRatio: 0.6,
        //   ),
        //   itemCount: value.wishList.length,
        //   itemBuilder: (context, index) {
        //     return ProductCard(plant: value.wishList[index]);
        //   },
        // ),
      ),
    );
  }
}
