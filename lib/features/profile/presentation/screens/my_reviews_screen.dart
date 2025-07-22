import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_shadows.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // Mock reviews data
    final reviews = [
      {
        'product': 'Aloe Vera',
        'rating': 5,
        'review': 'Great plant, very healthy and easy to care for!',
        'date': '2024-06-01',
      },
      {
        'product': 'Snake Plant',
        'rating': 4,
        'review': 'Arrived in good condition, looks beautiful.',
        'date': '2024-05-20',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reviews', style: textTheme.headlineMedium),
       
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
            size: AppSizes.iconMd,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          reviews.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.rate_review,
                      size: 64.r,
                      color: colorScheme.primary,
                    ),
                    SizedBox(height: 16.h),
                    Text('No reviews yet', style: textTheme.headlineMedium),
                    SizedBox(height: 8.h),
                    Text(
                      'You haven\'t reviewed any products yet.',
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              )
              : ListView.separated(
                padding: AppSizes.paddingAllSm,
                itemCount: reviews.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Container(
                    padding: AppSizes.paddingAllMd,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                      boxShadow: AppShadows.elevatedShadow(context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              review['product'] as String,
                              style: textTheme.titleLarge,
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (star) => Icon(
                                  star < (review['rating'] as int)
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: AppSizes.iconSm,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          review['review'] as String,
                          style: textTheme.bodyMedium,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          review['date'] as String,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
