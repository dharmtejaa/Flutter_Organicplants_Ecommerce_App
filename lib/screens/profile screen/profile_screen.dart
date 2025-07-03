import 'package:flutter/material.dart';
import 'package:organicplants/providers/theme_provider.dart';
import 'package:organicplants/services/app_sizes.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context),
            SizedBox(height: AppSizes.spaceMd),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) => themeProvider.toggleTheme(value),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Account Settings"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("About Us"),
              onTap: () {},
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                onPressed: () {},
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
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
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
}
