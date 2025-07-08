import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service'),
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
                'Terms of Service',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 18.h),
              Text(
                'This is a placeholder for your terms of service. Here you can outline the rules and guidelines for using your app.\n\n'
                '1. Acceptance\nBy using this app, you agree to these terms.\n\n'
                '2. Usage\nYou agree to use the app responsibly and not misuse its features.\n\n'
                '3. Changes\nWe may update these terms from time to time.\n\n'
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
