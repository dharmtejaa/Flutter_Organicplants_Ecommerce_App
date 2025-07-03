import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/screens/store%20screen/store_screen.dart';
import 'package:organicplants/services/all_plants_global_data.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:organicplants/theme/app_theme.dart';
import 'package:organicplants/widgets/custom_widgets/plantcategory.dart';

class SearchByCategory extends StatelessWidget {
  const SearchByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: AppSizes.paddingSymmetricSm,
      child: Container(
        //margin: AppSizes.marginAllXs,
        width: double.infinity,
        height: 0.2.sh, // Adjusted height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color:
                  colorScheme.brightness == Brightness.dark
                      // ignore: deprecated_member_use
                      ? Colors.black.withOpacity(0.1)
                      // ignore: deprecated_member_use
                      : Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(AppSizes.paddingMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select by Category',
                  style: TextStyle(
                    fontSize: AppSizes.fontMd,
                    //fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StoreTab()),
                    );
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                      fontSize: AppSizes.fontSm,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),

            //SizedBox(height: height * 0.01),

            // Horizontal Category List
            SizedBox(
              height: 0.13.sh,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
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
                    child: Padding(
                      padding: EdgeInsets.only(right: AppSizes.paddingSm),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  colorScheme.brightness == Brightness.dark
                                      ? AppTheme.darkCard
                                      : AppTheme.lightCard,
                              boxShadow: [
                                BoxShadow(
                                  // ignore: deprecated_member_use
                                  color:
                                      colorScheme.brightness == Brightness.dark
                                          // ignore: deprecated_member_use
                                          ? Colors.black.withOpacity(0.1)
                                          // ignore: deprecated_member_use
                                          : Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(
                                    0,
                                    3,
                                  ), // shadow for favorite icon
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(AppSizes.paddingSm),
                            child: ClipOval(
                              child: Image.asset(
                                categories[index]['imagePath']!,
                                width: 60.w,
                                height: 70.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          //SizedBox(height: height * 0.01),
                          Text(
                            categories[index]['title']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: AppSizes.fontSm,
                              //fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface,
                            ),
                            // maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
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
    );
  }
}
