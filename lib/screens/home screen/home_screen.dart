import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/screens/cart%20screen/cart_screen.dart';
import 'package:organicplants/screens/home%20screen/views/components/auto_banner_with_notifier.dart';
import 'package:organicplants/screens/home%20screen/views/components/plant_section_widget.dart';
import 'package:organicplants/screens/home%20screen/views/components/search_by_category.dart';
import 'package:organicplants/services/all_plants_global_data.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/widgets/components/cart_icon_with_batdge.dart';
import 'package:organicplants/widgets/components/wishlist_icon_with_badge.dart';
import 'package:organicplants/widgets/custom_widgets/plantcategory.dart';
import 'package:organicplants/widgets/customButtons/searchbutton.dart';

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

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 0.006.sh),
              AutoBannerWithNotifier(),
              SizedBox(height: 0.006.sh),
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
        ),
      ),
    );
  }
}
