import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "About Organic Plants",
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primaryContainer,
                    colorScheme.secondaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.eco_rounded,
                    size: 64.r,
                    color: colorScheme.onPrimaryContainer,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Organic Plants",
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Bringing Nature to Your Home",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Our Story Section
            _buildSection(
              "Our Story",
              Icons.history_edu_outlined,
              "Organic Plants was founded with a simple mission: to make the joy of plant parenthood accessible to everyone. We believe that every home deserves the beauty and benefits that plants bring.\n\nOur journey began in 2020 when we noticed that many people wanted to bring plants into their homes but were intimidated by the complexity of plant care. We set out to change that by providing not just beautiful, healthy plants, but also the knowledge and support needed to help them thrive.",
            ),

            SizedBox(height: 24.h),

            // Our Mission Section
            _buildSection(
              "Our Mission",
              Icons.flag_outlined,
              "To inspire and empower people to create greener, healthier living spaces by providing premium plants, expert care guidance, and exceptional customer support.\n\nWe're committed to sustainability, quality, and making plant care accessible to everyone, from beginners to experienced gardeners.",
            ),

            SizedBox(height: 24.h),

            // What We Offer Section
            _buildFeaturesSection(),

            SizedBox(height: 24.h),

            // Team Section
            _buildTeamSection(),

            SizedBox(height: 24.h),

            // Contact Information
            _buildContactSection(),

            SizedBox(height: 24.h),

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

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary, size: 24.r),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              content,
              style: TextStyle(
                fontSize: 16.sp,
                color: colorScheme.onSurface,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star_outline,
                  color: colorScheme.primary,
                  size: 24.r,
                ),
                SizedBox(width: 12.w),
                Text(
                  "What We Offer",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildFeatureItem(
              "Premium Plants",
              "Carefully selected, healthy plants from trusted growers",
              Icons.local_florist_outlined,
            ),
            _buildFeatureItem(
              "Expert Care Guidance",
              "Detailed care instructions and plant care tips",
              Icons.menu_book_outlined,
            ),
            _buildFeatureItem(
              "Plant Care Support",
              "24/7 support from our plant care experts",
              Icons.support_agent_outlined,
            ),
            _buildFeatureItem(
              "Sustainable Packaging",
              "Eco-friendly packaging to protect your plants",
              Icons.recycling_outlined,
            ),
            _buildFeatureItem(
              "Plant Guarantee",
              "30-day guarantee on all our plants",
              Icons.verified_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: colorScheme.onPrimaryContainer,
              size: 20.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.people_outline,
                  color: colorScheme.primary,
                  size: 24.r,
                ),
                SizedBox(width: 12.w),
                Text(
                  "Our Team",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "We're a passionate team of plant enthusiasts, horticulturists, and customer service experts dedicated to helping you succeed in your plant journey.\n\nOur team includes certified plant care specialists who are always ready to answer your questions and provide personalized advice.",
              style: TextStyle(
                fontSize: 16.sp,
                color: colorScheme.onSurface,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.contact_support_outlined,
                  color: colorScheme.primary,
                  size: 24.r,
                ),
                SizedBox(width: 12.w),
                Text(
                  "Contact Us",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildContactItem(
              "Email",
              "support@organicplants.com",
              Icons.email_outlined,
              () => _launchEmail(),
            ),
            _buildContactItem(
              "Phone",
              "+91 98765 43210",
              Icons.phone_outlined,
              () => _launchPhone(),
            ),
            _buildContactItem(
              "Address",
              "123 Green Street, Garden Colony, Mumbai - 400001",
              Icons.location_on_outlined,
              () => _launchMaps(),
            ),
            _buildContactItem(
              "Business Hours",
              "Monday - Sunday: 9:00 AM - 8:00 PM",
              Icons.access_time_outlined,
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

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            children: [
              Icon(icon, color: colorScheme.primary, size: 20.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.r,
                  color: colorScheme.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.share_outlined,
                  color: colorScheme.primary,
                  size: 24.r,
                ),
                SizedBox(width: 12.w),
                Text(
                  "Follow Us",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialMediaButton(
                  "Instagram",
                  Icons.camera_alt_outlined,
                  Colors.purple,
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
                  Icons.flutter_dash,
                  Colors.lightBlue,
                  () => _launchSocialMedia("twitter"),
                ),
                _buildSocialMediaButton(
                  "YouTube",
                  Icons.play_circle_outline,
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
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24.r),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchEmail() {
    // TODO: Launch email app
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Opening email app...')));
  }

  void _launchPhone() {
    // TODO: Launch phone app
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Opening phone app...')));
  }

  void _launchMaps() {
    // TODO: Launch maps app
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Opening maps app...')));
  }

  void _launchSocialMedia(String platform) {
    // TODO: Launch social media app
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Opening $platform...')));
  }
}
