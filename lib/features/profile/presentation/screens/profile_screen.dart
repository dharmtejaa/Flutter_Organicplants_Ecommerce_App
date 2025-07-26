// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/app_shadows.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/core/theme/appcolors.dart';
import 'package:organicplants/features/profile/presentation/screens/loyalty_points_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/my_reviews_screen.dart';
import 'package:organicplants/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:provider/provider.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/shared/logic/theme_provider.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'package:organicplants/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:organicplants/features/profile/presentation/screens/personal_information_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/addresses_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/payment_methods_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/notifications_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/order_history_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/plant_care_guide_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/about_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/track_orders_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/returns_refunds_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/customer_support_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/faq_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/contact_us_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/terms_of_service_screen.dart';
import 'package:organicplants/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:organicplants/shared/widgets/custom_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      // backgroundColor:
      //     isDark ? DarkThemeColors.richBlack : LightThemeColors.mediumGray,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 0, bottom: 32.h),
        child: Column(
          children: [
            const ProfileHeaderCard(),
            // Enhanced Quick Actions with theme-aware colors
            SizedBox(height: 10.h),

            // Enhanced Stats Cards with theme-aware colors
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _enhancedMiniStatCard(
                    context,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrackOrdersScreen(),
                        ),
                      );
                    },
                    'Orders',
                    profileProvider.totalOrders.toString(),
                    Icons.shopping_bag_rounded,
                    colorScheme.primary,
                  ),
                  _enhancedMiniStatCard(
                    context,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WishlistScreen(),
                        ),
                      );
                    },
                    'Wishlist',
                    profileProvider.wishlistItems.toString(),
                    Icons.favorite_rounded,
                    colorScheme.primary,
                  ),
                  _enhancedMiniStatCard(
                    context,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyReviewsScreen(),
                        ),
                      );
                    },
                    'Reviews',
                    profileProvider.reviewsGiven.toString(),
                    Icons.star_rounded,
                    colorScheme.primary,
                  ),
                  _enhancedMiniStatCard(
                    context,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoyaltyPointsScreen(),
                        ),
                      );
                    },
                    'Points',
                    profileProvider.formattedLoyaltyPoints,
                    Icons.card_giftcard_rounded,
                    colorScheme.primary,
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // Enhanced Menu Sections with theme-aware colors
            Padding(
              padding: AppSizes.paddingAllSm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileMenuSection(
                    color: colorScheme.primary,
                    title: 'Shopping & Orders',

                    items: [
                      ProfileMenuItem(
                        title: 'Track Orders',
                        subtitle: 'Track your current orders',
                        icon: Icons.local_shipping_outlined,
                        iconColor: Colors.teal,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrackOrdersScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: 'Order History',
                        subtitle: 'View all your past orders',
                        icon: Icons.history_rounded,
                        iconColor: Colors.indigo,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderHistoryScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: 'Returns & Refunds',
                        subtitle: 'Manage returns and refunds',
                        icon: Icons.assignment_return_outlined,
                        iconColor: Colors.amber,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReturnsRefundsScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: 'Plant Care Guide',
                        subtitle: 'Learn how to care for your plants',
                        icon: Icons.eco_outlined,
                        iconColor: Colors.lightGreen,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlantCareGuideScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  ProfileMenuSection(
                    color: AppTheme.secondaryColor,
                    title: 'Account & Settings',
                    items: [
                      ProfileMenuItem(
                        title: 'Personal Information',
                        subtitle: 'Manage your profile details',
                        icon: Icons.person_outline_rounded,
                        iconColor: Colors.blue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonalInformationScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: 'Addresses',
                        subtitle: 'Manage delivery addresses',
                        icon: Icons.location_on_outlined,
                        iconColor: Colors.green,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddressesScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: 'Payment Methods',
                        subtitle: 'Manage payment options',
                        icon: Icons.payment_rounded,
                        iconColor: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentMethodsScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: 'Notifications',
                        subtitle: 'Manage notification preferences',
                        icon: Icons.notifications_outlined,
                        iconColor: Colors.purple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  ProfileMenuSection(
                    title: 'App Settings',
                    color: colorScheme.primary,
                    items: [
                      ProfileMenuItem(
                        title: "Theme",
                        subtitle: "Choose your preferred theme",
                        icon: Icons.palette_outlined,
                        iconColor: Colors.deepPurple,
                        trailing: Consumer<ThemeProvider>(
                          builder: (context, themeProvider, child) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radiusXl,
                                ),
                              ),
                              child: Text(
                                _getThemeModeText(themeProvider.themeMode),
                                style: textTheme.labelMedium?.copyWith(
                                  color: colorScheme.primaryFixed,
                                ),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          _showThemeDialog(context, themeProvider);
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  ProfileMenuSection(
                    title: 'Support & Help',
                    color: AppColors.info,
                    items: [
                      ProfileMenuItem(
                        title: 'Customer Support',
                        subtitle: 'Get help and support',
                        icon: Icons.support_agent_outlined,
                        iconColor: Colors.tealAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerSupportScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: 'FAQ',
                        subtitle: 'Frequently asked questions',
                        icon: Icons.help_outline_rounded,
                        iconColor: Colors.lightBlueAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FAQScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: 'Contact Us',
                        subtitle: 'Reach out to our team',
                        icon: Icons.contact_support_outlined,
                        iconColor: Colors.orangeAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactUsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  ProfileMenuSection(
                    title: 'Legal & Privacy',
                    color: AppColors.warning,
                    items: [
                      ProfileMenuItem(
                        title: 'Privacy Policy',
                        subtitle: 'Read our privacy policy',
                        icon: Icons.privacy_tip_outlined,
                        iconColor: Colors.redAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacyPolicyScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: 'Terms of Service',
                        subtitle: 'Read our terms of service',
                        icon: Icons.description_outlined,
                        iconColor: Colors.redAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TermsOfServiceScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: 'About',
                        subtitle: 'Learn more about us',
                        icon: Icons.info_outline_rounded,
                        iconColor: Colors.blueAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  ProfileMenuSection(
                    title: 'Account Actions',
                    color: AppColors.error,
                    items: [
                      ProfileMenuItem(
                        title: 'Logout',
                        subtitle: 'Sign out of your account',
                        icon: Icons.logout_rounded,
                        iconColor: Colors.redAccent,
                        onTap: () => _showLogoutDialog(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Enhanced decorative blob with theme-aware colors

  // Enhanced mini stat card with theme-aware colors
  Widget _enhancedMiniStatCard(
    BuildContext context,
    VoidCallback onTap,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 75.w,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),

          boxShadow: AppShadows.cardShadow(context),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.1),
              ),
              child: Icon(icon, color: color, size: AppSizes.iconSm),
            ),
            SizedBox(height: 6.h),
            Text(
              value,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(label, style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  String _getThemeModeText(ThemeMode mode) =>
      mode == ThemeMode.light
          ? 'Light'
          : mode == ThemeMode.dark
          ? 'Dark'
          : 'System';

  void _showThemeDialog(BuildContext context, ThemeProvider themeProvider) {
    final themeOptions = [
      {
        'mode': ThemeMode.system,
        'title': 'System Default',
        'icon': Icons.brightness_auto_rounded,
      },
      {
        'mode': ThemeMode.light,
        'title': 'Light Mode',
        'icon': Icons.light_mode_rounded,
      },
      {
        'mode': ThemeMode.dark,
        'title': 'Dark Mode',
        'icon': Icons.dark_mode_rounded,
      },
    ];
    CustomDialog.showCustom(
      context: context,
      title: 'Choose Theme',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            themeOptions.map((opt) {
              final mode = opt['mode'] as ThemeMode;
              final isSelected = themeProvider.themeMode == mode;
              final colorScheme = Theme.of(context).colorScheme;
              final textTheme = Theme.of(context).textTheme;
              return ListTile(
                leading: Icon(
                  opt['icon'] as IconData,
                  color:
                      isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                ),
                title: Text(
                  opt['title'] as String,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color:
                        isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurface,
                  ),
                ),
                trailing:
                    isSelected
                        ? Icon(Icons.check_rounded, color: colorScheme.primary)
                        : null,
                onTap: () {
                  themeProvider.setThemeMode(mode);
                  Navigator.pop(context);
                },
              );
            }).toList(),
      ),
      showCancelButton: false,
      showConfirmButton: false,
      icon: Icons.palette_outlined,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    CustomDialog.showDeleteConfirmation(
      context: context,
      title: 'Logout',
      content:
          'Are you sure you want to logout? You will need to sign in again to access your account.',
      confirmText: 'Confirm',
      onDelete: () async {
        await FirebaseAuth.instance.signOut();
        await Future.delayed(Duration(milliseconds: 100)); // optional quick fix

        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EntryScreen()),
        );
      },
    );
  }
}
