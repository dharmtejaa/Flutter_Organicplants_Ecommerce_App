import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';

class LoyaltyPointsScreen extends StatelessWidget {
  const LoyaltyPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // Mock data
    final int points = 320;
    final int nextReward = 500;
    final transactions = [
      {'title': 'Purchase: Aloe Vera', 'points': 50, 'date': '2024-06-01'},
      {'title': 'Referral Bonus', 'points': 100, 'date': '2024-05-25'},
      {'title': 'Purchase: Snake Plant', 'points': 70, 'date': '2024-05-20'},
      {'title': 'Welcome Bonus', 'points': 100, 'date': '2024-05-10'},
    ];
    double progress = points / nextReward;
    return Scaffold(
      appBar: AppBar(
        title: Text('Loyalty Points', style: textTheme.headlineMedium),
       
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
            size: AppSizes.iconMd,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: AppSizes.paddingAllSm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.card_giftcard,
                    size: 64.r,
                    color: colorScheme.primary,
                  ),
                  SizedBox(height: 12.h),
                  Text('$points pts', style: textTheme.headlineMedium),
                  SizedBox(height: 4.h),
                  Text('Total Loyalty Points', style: textTheme.bodyMedium),
                  SizedBox(height: 16.h),
                  LinearProgressIndicator(
                    value: progress > 1 ? 1 : progress,
                    minHeight: 10.h,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(colorScheme.primary),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Next reward at $nextReward pts',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            Text('Recent Activity', style: textTheme.titleLarge),
            SizedBox(height: 12.h),
            Expanded(
              child:
                  transactions.isEmpty
                      ? Center(
                        child: Text(
                          'No loyalty activity yet.',
                          style: textTheme.bodyMedium,
                        ),
                      )
                      : ListView.separated(
                        itemCount: transactions.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10.h),
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          return Container(
                            padding: AppSizes.paddingAllMd,
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusLg,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tx['title'] as String,
                                      style: textTheme.bodyMedium,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      tx['date'] as String,
                                      style: textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                Text(
                                  '+${tx['points']} pts',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
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
