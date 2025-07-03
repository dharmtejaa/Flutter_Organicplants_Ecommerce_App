import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/providers/wishlist_provider.dart';
import 'package:organicplants/screens/cart%20screen/cart_screen.dart';
import 'package:organicplants/screens/wishlist%20screen/views/components/product_tile.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/widgets/components/cart_icon_with_batdge.dart';
import 'package:organicplants/widgets/components/no_result_found.dart';
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
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: AppSizes.fontXl,
            //fontWeight: FontWeight.bold,
          ),
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
      body:
          wishListProvider.wishList.isEmpty
              ? Center(
                child: NoResultsFound(
                  title: "Your Wishlist is empty",
                  message: "Add some plants to get started!",
                  imagePath: "assets/No_Plant_Found.png",
                ),
              )
              : Flexible(
                child: Consumer<WishlistProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
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
              ),
    );
  }
}
