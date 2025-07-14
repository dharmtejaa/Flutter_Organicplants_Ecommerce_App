import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/appcolors.dart';
import 'package:organicplants/features/profile/presentation/widgets/profile_custom_icon.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("About Organic Plants", style: textTheme.headlineMedium),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
            size: AppSizes.iconMd,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSizes.paddingAllSm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: AppSizes.paddingAllSm,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primaryContainer, colorScheme.surface],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.eco_rounded,
                    size: AppSizes.iconXl,
                    color: colorScheme.onPrimary,
                  ),
                  SizedBox(height: 16.h),
                  Text("Organic Plants", style: textTheme.headlineMedium),
                  SizedBox(height: 8.h),
                  Text(
                    "Bringing Nature to Your Home",
                    style: textTheme.bodyMedium,
                  ),
                  SizedBox(height: 16.h),
                  Text("Version 1.0.0", style: textTheme.bodyMedium),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Our Story Section
            _buildSection(
              "Our Story",
              Icons.history_edu_rounded,
              "Organic Plants was founded with a simple\n\nmission: to make the joy of plant parenthood accessible to everyone. We believe that every home deserves the beauty and benefits that plants bring.\n\nOur journey began in 2020 when we noticed that many people wanted to bring plants into their homes but were intimidated by the complexity of plant care. We set out to change that by providing not just beautiful, healthy plants, but also the knowledge and support needed to help them thrive.",
            ),

            SizedBox(height: 16.h),

            // Our Mission Section
            _buildSection(
              "Our Mission",
              Icons.flag_outlined,
              "To inspire and empower people to create greener, healthier living spaces by providing premium plants, expert care guidance, and exceptional customer support.\n\nWe're committed to sustainability, quality, and making plant care accessible to everyone, from beginners to experienced gardeners.",
            ),

            SizedBox(height: 16.h),

            // What We Offer Section
            _buildFeaturesSection(),

            SizedBox(height: 16.h),

            // Team Section
            _buildTeamSection(),

            SizedBox(height: 16.h),

            // Contact Information
            _buildContactSection(),

            SizedBox(height: 16.h),

            // Social Media Links
            _buildSocialMediaSection(),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, String content) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Padding(
        padding: AppSizes.paddingAllMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary, size: AppSizes.iconMd),
                SizedBox(width: 12.w),
                Text(title, style: textTheme.headlineMedium),
              ],
            ),
            SizedBox(height: 16.h),
            Text(content, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Padding(
        padding: AppSizes.paddingAllMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star_outline,
                  color: colorScheme.primary,
                  size: AppSizes.iconMd,
                ),
                SizedBox(width: 12.w),
                Text("What We Offer", style: textTheme.headlineMedium),
              ],
            ),
            SizedBox(height: 16.h),
            _buildFeatureItem(
              "Premium Plants",
              "Carefully selected, healthy plants from trusted growers",
              Icons.local_florist_rounded,
              Colors.yellow,
            ),
            _buildFeatureItem(
              "Expert Care Guidance",
              "Detailed care instructions and plant care tips",
              Icons.menu_book_rounded,
              Colors.deepOrangeAccent,
            ),
            _buildFeatureItem(
              "Plant Care Support",
              "24/7 support from our plant care experts",
              Icons.support_agent_rounded,
              Colors.grey,
            ),
            _buildFeatureItem(
              "Sustainable Packaging",
              "Eco-friendly packaging to protect your plants",
              Icons.recycling_rounded,
              Colors.green,
            ),
            _buildFeatureItem(
              "Plant Guarantee",
              "30-day guarantee on all our plants",
              Icons.verified_rounded,
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.paddingLg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileCustomIcon(icon: icon, iconColor: color),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.titleMedium),
                ...[
                  SizedBox(height: AppSizes.spaceXs),
                  Text(
                    description,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.mutedText,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Padding(
        padding: AppSizes.paddingAllMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.people_outline,
                  color: colorScheme.primary,
                  size: AppSizes.iconMd,
                ),
                SizedBox(width: 12.w),
                Text("Our Team", style: textTheme.headlineMedium),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "We're a passionate team of plant enthusiasts, horticulturists, and customer service experts dedicated to helping you succeed in your plant journey.\n\nOur team includes certified plant care specialists who are always ready to answer your questions and provide personalized advice.",
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Padding(
        padding: AppSizes.paddingAllMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.contact_support_rounded,
                  color: colorScheme.primary,
                  size: AppSizes.iconMd,
                ),
                SizedBox(width: 12.w),
                Text("Contact Us", style: textTheme.headlineMedium),
              ],
            ),
            SizedBox(height: 16.h),
            _buildContactItem(
              "Email",
              "support@organicplants.com",
              Icons.email_rounded,
              () => _launchEmail(),
            ),
            _buildContactItem(
              "Phone",
              "+91 98765 43210",
              Icons.phone_rounded,
              () => _launchPhone(),
            ),
            _buildContactItem(
              "Address",
              "123 Green Street, Garden Colony, Mumbai - 400001",
              Icons.location_on_rounded,
              () => _launchMaps(),
            ),
            _buildContactItem(
              "Business Hours",
              "Monday - Sunday: 9:00 AM - 8:00 PM",
              Icons.access_time_rounded,
              null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(
    String title,
    String value,
    IconData icon,
    VoidCallback? onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.paddingSm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Padding(
          padding: AppSizes.paddingAllSm,
          child: Row(
            children: [
              Icon(icon, color: colorScheme.primary, size: AppSizes.iconMd),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTheme.bodyMedium),
                    Text(
                      value,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.mutedText,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios,
                  size: AppSizes.iconSm,
                  color: AppColors.mutedText,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Padding(
        padding: AppSizes.paddingAllMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.share_outlined,
                  color: colorScheme.primary,
                  size: AppSizes.iconMd,
                ),
                SizedBox(width: 12.w),
                Text("Follow Us", style: textTheme.headlineMedium),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialMediaButton(
                  "Instagram",
                  Icons.camera_alt_outlined,
                  Colors.redAccent,
                  () => _launchSocialMedia("instagram"),
                ),
                _buildSocialMediaButton(
                  "Facebook",
                  Icons.facebook_outlined,
                  Colors.blue,
                  () => _launchSocialMedia("facebook"),
                ),
                _buildSocialMediaButton(
                  "Twitter",
                  Icons.flutter_dash_outlined,
                  Colors.lightBlue,
                  () => _launchSocialMedia("twitter"),
                ),
                _buildSocialMediaButton(
                  "YouTube",
                  Icons.play_circle_outline_outlined,
                  Colors.red,
                  () => _launchSocialMedia("youtube"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      child: ProfileCustomIcon(icon: icon, iconColor: color),
    );
  }

  void _launchEmail() {
    CustomSnackBar.showInfo(context, "Opening email app...");
  }

  void _launchPhone() {
    CustomSnackBar.showInfo(context, "Opening phone app...");
  }

  void _launchMaps() {
    CustomSnackBar.showInfo(context, "Opening maps app...");
  }

  void _launchSocialMedia(String platform) {
    CustomSnackBar.showInfo(context, "Opening $platform...");
  }
}
