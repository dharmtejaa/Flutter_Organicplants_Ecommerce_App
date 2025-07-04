import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/home/presentation/widgets/auto_banner_with_notifier.dart';
import 'package:organicplants/features/home/presentation/widgets/search_by_category.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/searchbutton.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/widgets/plant_section_widget.dart';
import 'package:organicplants/shared/widgets/plantcategory.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Text(
          'Organic Plants',
          style: TextStyle(
            fontSize: AppSizes.fontXxl,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        actions: [
          SearchButton(),
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

      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 5.h),
          AutoBannerWithNotifier(),
          SizedBox(height: 5.h),
          SearchByCategory(),
          PlantSectionWidget(
            title: "Air Purifying",
            onSeeAll: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PlantCategory(
                        plant: airPurifyingPlants,
                        category: "Air Purifying Plants",
                      ),
                ),
              );
            },
            plants: airPurifyingPlants,
          ),
          PlantSectionWidget(
            title: "Low Maintenance",
            onSeeAll: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PlantCategory(
                        plant: lowMaintenancePlants,
                        category: "Low Maintenance Plants",
                      ),
                ),
              );
            },
            plants: lowMaintenancePlants,
          ),
          PlantSectionWidget(
            title: "Pet Friendly",
            onSeeAll: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PlantCategory(
                        plant: petFriendlyPlants,
                        category: "Pet Friendly Plants",
                      ),
                ),
              );
            },
            plants: petFriendlyPlants,
          ),
          PlantSectionWidget(
            title: "Sun Loving",
            onSeeAll: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PlantCategory(
                        plant: petFriendlyPlants,
                        category: "Sun Loving Plants",
                      ),
                ),
              );
            },
            plants: sunLovingPlants,
          ),
        ],
      ),
    );
  }
}
