import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShareAppScreen extends StatelessWidget {
  const ShareAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Share App'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.share, color: colorScheme.primary, size: 64.r),
            SizedBox(height: 24.h),
            Text(
              'Share Organic Plants with your friends and family!',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement actual share logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Share functionality coming soon!')),
                  );
                },
                icon: Icon(Icons.share),
                label: Text('Share Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
