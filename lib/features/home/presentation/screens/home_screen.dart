import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/all_plants_global_data.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/home/presentation/widgets/auto_banner_with_notifier.dart';
import 'package:organicplants/features/home/presentation/widgets/search_by_category.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/searchbutton.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/features/home/presentation/widgets/plant_section_widget.dart';
import 'package:organicplants/shared/widgets/plantcategory.dart';
import 'package:provider/provider.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Organic Plants', style: textTheme.displaySmall),
                SizedBox(height: 2.h),
                Text(
                  '${getGreeting()}, ${profileProvider.userName}! 🌱',
                  style: textTheme.bodySmall,
                ),
              ],
            );
          },
        ),
        actions: [
          SearchButton(),
          SizedBox(width: 10.w),
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
          SizedBox(height: 10.h),
          AutoBannerWithNotifier(),
          SizedBox(height: 5.h),
          SearchByCategory(),
          //SizedBox(height: 5.h),
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
