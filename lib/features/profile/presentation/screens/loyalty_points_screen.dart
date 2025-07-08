import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoyaltyPointsScreen extends StatelessWidget {
  const LoyaltyPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
        title: Text('Loyalty Points'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.card_giftcard_rounded,
                    size: 64.r,
                    color: colorScheme.primary,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    '$points pts',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Total Loyalty Points',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
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
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child:
                  transactions.isEmpty
                      ? Center(
                        child: Text(
                          'No loyalty activity yet.',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                      : ListView.separated(
                        itemCount: transactions.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10.h),
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          return Container(
                            padding: EdgeInsets.all(14.w),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tx['title'] as String,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      tx['date'] as String,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '+${tx['points']} pts',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w700,
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
