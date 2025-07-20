import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_shadows.dart';
import 'package:organicplants/core/theme/appcolors.dart';
// ignore: unused_import
import 'package:organicplants/core/theme/light_theme_colors.dart';
import 'package:organicplants/features/profile/presentation/screens/personal_information_screen.dart';
import 'package:provider/provider.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final profileProvider = Provider.of<ProfileProvider>(context);

    //final profileProvider = Provider.of<ProfileProvider>(context);
    return SizedBox(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 240.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 146, 241, 197),
                    Color.fromARGB(255, 35, 172, 101),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
            ),
          ),
          Positioned(
            top: 80.h,
            left: -50.w,
            child: _decorativeBlob(AppColors.warning, 140),
          ),
          Positioned(
            top: 120.h,
            right: -40.w,
            child: _decorativeBlob(AppColors.success, 100),
          ),
          Positioned(
            top: 30.h,
            right: 60.w,
            child: _decorativeBlob(AppColors.warning, 60),
          ),
          // Enhanced decorative elements with theme-aware colors
          Column(
            children: [
              SizedBox(height: 60.h),

              // Enhanced Avatar with theme-aware styling
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: AppShadows.cardShadow(context),
                      ),
                      child: CircleAvatar(
                        radius: 60.r,
                        backgroundColor: colorScheme.surface,

                        backgroundImage:
                            profileProvider.userAvatar.isNotEmpty
                                ? NetworkImage(profileProvider.userAvatar)
                                : null,
                        child:
                            profileProvider.userAvatar.isEmpty
                                ? Icon(
                                  Icons.person,
                                  size: 58.r,
                                  color: colorScheme.primary,
                                )
                                : null,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonalInformationScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(06.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorScheme.surface,
                            boxShadow: AppShadows.cardShadow(context),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: colorScheme.primary,
                            size: AppSizes.iconMd,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Enhanced User Info Card with theme-aware colors
              Padding(
                padding: AppSizes.paddingAllSm,
                child: Container(
                  width: double.infinity,
                  padding: AppSizes.paddingAllXl,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                    boxShadow: AppShadows.cardShadow(context),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Hi, ${profileProvider.userName}! 🌱',
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        profileProvider.userEmail,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusLg,
                          ),
                          boxShadow: AppShadows.cardShadow(context),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.workspace_premium,
                              color: colorScheme.surface,
                              size: AppSizes.iconXs,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              '${profileProvider.membershipTier} Member',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.surface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _decorativeBlob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // ignore: deprecated_member_use
        color: color.withOpacity(0.15),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: color.withOpacity(0.2),
            blurRadius: 20.r,
            spreadRadius: 5.r,
          ),
        ],
      ),
    );
  }
}
