import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/models/all_plants_model.dart';
import 'package:organicplants/screens/cart%20screen/cart_screen.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/widgets/components/cart_icon_with_batdge.dart';
import 'package:organicplants/widgets/components/wishlist_icon_with_badge.dart';
import 'package:organicplants/widgets/custom_widgets/productcard.dart';
import 'package:organicplants/widgets/customButtons/searchbutton.dart';

class PlantCategory extends StatelessWidget {
  final List<AllPlantsModel> plant;
  final String category;
  const PlantCategory({super.key, required this.plant, required this.category});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    var totalPlantsCount = plant.length;
    final List<String> mainCategories = [
      'Indoor Plants',
      'Outdoor Plants',
      'Herbs Plants',
      'Succulents Plants',
      'Flowering Plants',
      'Bonsai Plants',
      'Medicinal Plants',
    ];
    final bool isMainCategory = mainCategories.contains(category);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: AppSizes.iconMd,
          onPressed: () {
            Navigator.pop(context);
          },
          color: colorScheme.onSurface,
        ),
        title: Text(
          category,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: AppSizes.fontLg,
            //fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          SearchButton(),
          WishlistIconWithBadge(),
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
      body: SafeArea(
        child: Padding(
          padding: AppSizes.paddingSymmetricSm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                "$totalPlantsCount Plants found",
                style: TextStyle(
                  fontSize: AppSizes.fontMd,
                  color: colorScheme.onSurface,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: GridView.builder(
                  itemCount: plant.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.8, // Adjusted for better aspect ratio
                  ),
                  itemBuilder: (context, index) {
                    return isMainCategory
                        ? ProductCard(plant: plant[index], scifiname: true)
                        : ProductCard(plant: plant[index]);
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
