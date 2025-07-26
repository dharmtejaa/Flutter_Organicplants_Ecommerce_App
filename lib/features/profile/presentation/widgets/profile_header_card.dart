import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/services/my_custom_cache_manager.dart';
import 'package:organicplants/core/theme/app_shadows.dart';
import 'package:organicplants/core/theme/appcolors.dart';
// ignore: unused_import
import 'package:organicplants/core/theme/light_theme_colors.dart';
import 'package:organicplants/features/profile/presentation/screens/personal_information_screen.dart';
import 'package:organicplants/shared/logic/user_profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Consumer<UserProfileProvider>(
      builder: (
        BuildContext context,
        UserProfileProvider userProfileProvider,
        Widget? child,
      ) {
        // Check if user is authenticated and profile exists
        if (!userProfileProvider.isAuthenticated ||
            userProfileProvider.userProfile == null) {
          return _buildLoadingOrErrorState(context, colorScheme, textTheme);
        }
        String userName = 'Nature Lover'; // Default value
        if (userProfileProvider.userProfile != null &&
            userProfileProvider.userProfile!.fullName.isNotEmpty) {
          final nameParts = userProfileProvider.userProfile!.fullName
              .trim()
              .split(' ');
          if (nameParts.length >= 2) {
            // Get the last name (last element in the array)
            userName = nameParts.last;
          } else {
            // If only one name, use it as is
            userName = nameParts.first;
          }
        } else {
          userName = 'Nature Lover';
        }

        return Stack(
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
                          radius: 55.r,
                          backgroundColor: colorScheme.surface,
                          child:
                              userProfileProvider
                                      .userProfile!
                                      .profileImageUrl
                                      .isNotEmpty
                                  ? ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          userProfileProvider
                                              .userProfile!
                                              .profileImageUrl,
                                      cacheManager:
                                          MyCustomCacheManager.instance,
                                      height: 110.h,
                                      width: 110.w,
                                      fit: BoxFit.cover,
                                      placeholder:
                                          (context, url) => Container(
                                            height: 110.h,
                                            width: 110.w,
                                            color:
                                                colorScheme
                                                    .surfaceContainerHighest,
                                            child: Icon(
                                              Icons.person,
                                              size: 50.r,
                                              color:
                                                  colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                      errorWidget:
                                          (context, url, error) => Container(
                                            height: 110.h,
                                            width: 110.w,
                                            color:
                                                colorScheme
                                                    .surfaceContainerHighest,
                                            child: Icon(
                                              Icons.error,
                                              size: 50.r,
                                              color: colorScheme.error,
                                            ),
                                          ),
                                    ),
                                  )
                                  : Container(
                                    height: 110.h,
                                    width: 110.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          colorScheme.surfaceContainerHighest,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 50.r,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
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
                                builder:
                                    (context) => PersonalInformationScreen(),
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
                          'Hi, ${userName.toString()}!',
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          userProfileProvider.userProfile!.email,
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
                            color: colorScheme.primary,
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
                                '$userName member',
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
        );
      },
    );
  }

  Widget _buildLoadingOrErrorState(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Stack(
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
        Column(
          children: [
            SizedBox(height: 60.h),
            Center(
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.cardShadow(context),
                ),
                child: CircleAvatar(
                  radius: 55.r,
                  backgroundColor: colorScheme.surface,
                  child: Container(
                    height: 110.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.surfaceContainerHighest,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 50.r,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
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
                child: Text(
                  'please login to continue',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
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
