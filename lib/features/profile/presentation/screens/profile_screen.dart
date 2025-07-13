import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/logic/theme_provider.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'package:organicplants/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:organicplants/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:organicplants/features/profile/presentation/widgets/quick_actions_grid.dart';
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
import 'package:organicplants/features/profile/presentation/screens/rate_app_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/share_app_screen.dart';
import 'package:organicplants/shared/widgets/custom_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: textTheme.headlineMedium),
        centerTitle: true,
        actions: [
          WishlistIconWithBadge(),
          SizedBox(width: 8.w),
          CartIconWithBadge(
            iconColor: colorScheme.onSurface,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            // Profile Header Card
            const ProfileHeaderCard(),
            SizedBox(height: 12.h),

            // Quick Actions Grid
            const QuickActionsGrid(),
            SizedBox(height: 16.h),

            // Shopping Section (Most Important - Place First)
            ProfileMenuSection(
              title: "Shopping & Orders",
              items: [
                // Track Orders (Most Important - Place First)
                ProfileMenuItem(
                  title: "Track Orders",
                  subtitle: "Track your current orders",
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
                // Order History
                ProfileMenuItem(
                  title: "Order History",
                  subtitle: "View all your past orders",
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
                // Returns & Refunds
                ProfileMenuItem(
                  title: "Returns & Refunds",
                  subtitle: "Manage returns and refunds",
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
                // Plant Care Guide
                ProfileMenuItem(
                  title: "Plant Care Guide",
                  subtitle: "Learn how to care for your plants",
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

            // Account & Settings Section
            ProfileMenuSection(
              title: "Account & Settings",
              items: [
                // Personal Information
                ProfileMenuItem(
                  title: "Personal Information",
                  subtitle: "Manage your profile details",
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
                // Addresses
                ProfileMenuItem(
                  title: "Addresses",
                  subtitle: "Manage delivery addresses",
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
                // Payment Methods
                ProfileMenuItem(
                  title: "Payment Methods",
                  subtitle: "Manage payment options",
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
                // Notifications
                ProfileMenuItem(
                  title: "Notifications",
                  subtitle: "Manage notification preferences",
                  icon: Icons.notifications_outlined,
                  iconColor: Colors.purple,
                  trailing: Consumer<ProfileProvider>(
                    builder: (context, provider, child) {
                      return Switch(
                        value: provider.notificationsEnabled,
                        onChanged: provider.toggleNotifications,
                        activeColor: colorScheme.primary,
                      );
                    },
                  ),
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

            // App Settings Section
            ProfileMenuSection(
              title: "App Settings",
              items: [
                // Theme
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
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getThemeModeText(themeProvider.themeMode),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    _showThemeDialog(context, themeProvider);
                  },
                ),
                // Language
                ProfileMenuItem(
                  title: "Language",
                  subtitle: "Choose your language",
                  icon: Icons.language_rounded,
                  iconColor: Colors.brown,
                  trailing: Consumer<ProfileProvider>(
                    builder: (context, provider, child) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          provider.language,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    _showLanguageDialog(context);
                  },
                ),
                // Currency
                ProfileMenuItem(
                  title: "Currency",
                  subtitle: "Choose your currency",
                  icon: Icons.attach_money_rounded,
                  iconColor: Colors.green,
                  trailing: Consumer<ProfileProvider>(
                    builder: (context, provider, child) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          provider.currency,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    _showCurrencyDialog(context);
                  },
                ),
              ],
            ),

            // Support Section
            ProfileMenuSection(
              title: "Support & Help",
              items: [
                // Customer Support
                ProfileMenuItem(
                  title: "Customer Support",
                  subtitle: "Get help from our team",
                  icon: Icons.support_agent_rounded,
                  iconColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerSupportScreen(),
                      ),
                    );
                  },
                ),
                // FAQ
                ProfileMenuItem(
                  title: "FAQ",
                  subtitle: "Frequently asked questions",
                  icon: Icons.help_outline_rounded,
                  iconColor: Colors.grey,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQScreen()),
                    );
                  },
                ),
                // Contact Us
                ProfileMenuItem(
                  title: "Contact Us",
                  subtitle: "Reach out to us",
                  icon: Icons.contact_support_outlined,
                  iconColor: Colors.cyan,
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

            // About & Legal Section
            ProfileMenuSection(
              title: "About & Legal",
              items: [
                // About Organic Plants
                ProfileMenuItem(
                  title: "About Organic Plants",
                  subtitle: "Learn more about us",
                  icon: Icons.info_outline_rounded,
                  iconColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutScreen()),
                    );
                  },
                ),
                // Privacy Policy
                ProfileMenuItem(
                  title: "Privacy Policy",
                  subtitle: "Read our privacy policy",
                  icon: Icons.privacy_tip_outlined,
                  iconColor: Colors.blueGrey,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen(),
                      ),
                    );
                  },
                ),
                // Terms of Service
                ProfileMenuItem(
                  title: "Terms of Service",
                  subtitle: "Read our terms of service",
                  icon: Icons.description_outlined,
                  iconColor: Colors.blueGrey,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsOfServiceScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),

            // App Actions Section
            ProfileMenuSection(
              title: "App Actions",
              items: [
                // Rate Our App
                ProfileMenuItem(
                  title: "Rate Our App",
                  subtitle: "Share your feedback",
                  icon: Icons.star_outline_rounded,
                  iconColor: Colors.amber,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RateAppScreen()),
                    );
                  },
                ),
                // Share App
                ProfileMenuItem(
                  title: "Share App",
                  subtitle: "Share with friends and family",
                  icon: Icons.share_rounded,
                  iconColor: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShareAppScreen()),
                    );
                  },
                ),
                // Logout
                ProfileMenuItem(
                  title: "Logout",
                  subtitle: "Sign out of your account",
                  icon: Icons.logout_rounded,
                  iconColor: Colors.red,
                  isDestructive: true,
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  void _showThemeDialog(BuildContext context, ThemeProvider themeProvider) {
    CustomDialog.showCustom(
      context: context,
      title: 'Choose Theme',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildThemeOption(
            context,
            themeProvider,
            ThemeMode.system,
            'System Default',
            Icons.brightness_auto_rounded,
          ),
          _buildThemeOption(
            context,
            themeProvider,
            ThemeMode.light,
            'Light Mode',
            Icons.light_mode_rounded,
          ),
          _buildThemeOption(
            context,
            themeProvider,
            ThemeMode.dark,
            'Dark Mode',
            Icons.dark_mode_rounded,
          ),
        ],
      ),
      showCancelButton: false,
      showConfirmButton: false,
      icon: Icons.palette_outlined,
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    ThemeProvider themeProvider,
    ThemeMode mode,
    String title,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = themeProvider.themeMode == mode;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
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
  }

  void _showLanguageDialog(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    CustomDialog.showCustom(
      context: context,
      title: 'Choose Language',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLanguageOption(context, profileProvider, 'English', 'English'),
          _buildLanguageOption(context, profileProvider, 'Hindi', 'हिंदी'),
          _buildLanguageOption(context, profileProvider, 'Spanish', 'Español'),
          _buildLanguageOption(context, profileProvider, 'French', 'Français'),
        ],
      ),
      showCancelButton: false,
      showConfirmButton: false,
      icon: Icons.language_rounded,
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    ProfileProvider profileProvider,
    String title,
    String nativeName,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = profileProvider.language == title;

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        nativeName,
        style: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
      trailing:
          isSelected
              ? Icon(Icons.check_rounded, color: colorScheme.primary)
              : null,
      onTap: () {
        profileProvider.updateLanguage(title);
        Navigator.pop(context);
      },
    );
  }

  void _showCurrencyDialog(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    CustomDialog.showCustom(
      context: context,
      title: 'Choose Currency',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCurrencyOption(
            context,
            profileProvider,
            '₹ INR',
            'Indian Rupee',
          ),
          _buildCurrencyOption(context, profileProvider, '\$ USD', 'US Dollar'),
          _buildCurrencyOption(context, profileProvider, '€ EUR', 'Euro'),
          _buildCurrencyOption(
            context,
            profileProvider,
            '£ GBP',
            'British Pound',
          ),
        ],
      ),
      showCancelButton: false,
      showConfirmButton: false,
      icon: Icons.attach_money_rounded,
    );
  }

  Widget _buildCurrencyOption(
    BuildContext context,
    ProfileProvider profileProvider,
    String title,
    String fullName,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = profileProvider.currency == title;

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        fullName,
        style: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
      trailing:
          isSelected
              ? Icon(Icons.check_rounded, color: colorScheme.primary)
              : null,
      onTap: () {
        profileProvider.updateCurrency(title);
        Navigator.pop(context);
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    CustomDialog.showDeleteConfirmation(
      context: context,
      title: 'Logout',
      content:
          'Are you sure you want to logout? You will need to sign in again to access your account.',
      onDelete: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EntryScreen()),
        );
      },
    );
  }
}
