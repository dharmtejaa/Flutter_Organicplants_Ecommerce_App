import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/widgets/plantcategory.dart';

class StoreTab extends StatefulWidget {
  const StoreTab({super.key});

  @override
  State<StoreTab> createState() => _StoreTabState();
}

class _StoreTabState extends State<StoreTab> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: AppSizes.iconMd,
          color: colorScheme.onSurface,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EntryScreen()),
            );
          },
        ),
        title: Text(
          "Organic Plants Store",
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: AppSizes.fontLg,
            //fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          WishlistIconWithBadge(),
          SizedBox(width: 10.w),
          CartIconWithBadge(
            iconColor: colorScheme.onSurface,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSizes.paddingAllXs,
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1, // Adjusted for better aspect ratio
                  ),

                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.5.w,
                        vertical: 0.5.h,
                      ), //
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to PlantCategory with the selected category
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => PlantCategory(
                                    plant: getPlantsByCategory(
                                      categories[index]['filterTag']!
                                          .toLowerCase()
                                          .trim(),
                                    ),
                                    category: categories[index]['title']!,
                                  ),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                categories[index]['imagePath']!,
                                width: 0.25.sw,
                                height: 0.1.sh,
                                fit: BoxFit.cover,
                              ),
                            ),
                            //SizedBox(height: 4.h),
                            Text(
                              categories[index]['title']!,
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: AppSizes.fontLg,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
