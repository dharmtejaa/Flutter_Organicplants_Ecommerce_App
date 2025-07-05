import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/entry/presentation/screen/entry_screen.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:organicplants/shared/buttons/wishlist_icon_with_badge.dart';
import 'package:organicplants/shared/logic/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EntryScreen()),
            );
          },
          icon: Icon(
            Icons.arrow_back_sharp,
            color: colorScheme.onSurface,
            size: AppSizes.iconMd,
          ),
        ),
        title: Text(
          "Profile", // Corrected typo from "Profie"
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: AppSizes.fontXl,
          ),
        ),
        centerTitle: true,
        actions: [
          WishlistIconWithBadge(),
          SizedBox(width: 10.w),
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
      body: Padding(
        padding: EdgeInsets.all(AppSizes.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context),
            SizedBox(height: AppSizes.spaceMd),
            const Divider(),

            // Theme Selection Section (using RadioListTile for better choice)
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.vPaddingSm),
              child: Text(
                "App Theme",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
              ),
            ),
            _buildThemeOption(
              context,
              themeProvider,
              ThemeMode.system,
              "System Default",
              Icons.brightness_auto, // Icon for system default
            ),
            _buildThemeOption(
              context,
              themeProvider,
              ThemeMode.light,
              "Light Mode",
              Icons.light_mode, // Icon for light mode
            ),
            _buildThemeOption(
              context,
              themeProvider,
              ThemeMode.dark,
              "Dark Mode",
              Icons.dark_mode, // Icon for dark mode
            ),
            const Divider(), // Optional divider after theme options

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Account Settings"),
              onTap: () {
                // Handle account settings tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("About Us"),
              onTap: () {
                // Handle about us tap
              },
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                onPressed: () {
                  // Handle logout
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingLg,
                    vertical: AppSizes.vPaddingSm,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.person, size: 36, color: Colors.white),
        ),
        SizedBox(width: AppSizes.spaceMd),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "John Doe",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "john.doe@example.com",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  // Helper method to create a RadioListTile for each theme option
  Widget _buildThemeOption(
    BuildContext context,
    ThemeProvider themeProvider,
    ThemeMode mode,
    String title,
    IconData icon,
  ) {
    return RadioListTile<ThemeMode>(
      title: Text(title),
      secondary: Icon(icon, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
      value: mode,
      groupValue: themeProvider.themeMode, // The currently selected mode from the provider
      onChanged: (ThemeMode? newValue) {
        if (newValue != null) {
          themeProvider.setThemeMode(newValue); // Call the new setThemeMode method
        }
      },
      activeColor: Theme.of(context).colorScheme.primary, // Color when selected
    );
  }
}