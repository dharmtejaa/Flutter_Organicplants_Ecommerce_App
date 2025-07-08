import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 18.h),
              Text(
                'This is a placeholder for your privacy policy. Here you can explain how user data is collected, used, and protected.\n\n'
                '1. Data Collection\nWe collect information you provide when you use our app.\n\n'
                '2. Data Usage\nWe use your data to provide and improve our services.\n\n'
                '3. Data Protection\nWe take reasonable measures to protect your information.\n\n'
                'For more details, contact support.',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
