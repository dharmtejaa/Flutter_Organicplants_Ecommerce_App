import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/core/theme/appcolors.dart';
import 'package:organicplants/features/profile/presentation/widgets/profile_custom_icon.dart';
import 'package:organicplants/shared/widgets/custom_snackbar.dart';
import 'package:organicplants/shared/widgets/skip_button.dart';
import 'package:provider/provider.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'package:organicplants/shared/widgets/custom_dialog.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // final bool _pushNotifications = true;
  // final bool _emailNotifications = true;
  // final bool _smsNotifications = false;
  bool _orderUpdates = true;
  bool _promotionalOffers = false;
  bool _newProducts = true;
  bool _plantCareTips = true;
  bool _deliveryReminders = true;
  bool _priceDrops = false;
  bool _appUpdates = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications", style: textTheme.headlineMedium),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
            size: AppSizes.iconMd,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          SkipButton(
            onPressed: _savePreferences,
            text: "Save",
            textColor: colorScheme.primary,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSizes.paddingAllSm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General Notifications
            Consumer<ProfileProvider>(
              builder:
                  (context, provider, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader(
                        "General Notifications",
                        Icons.notifications_outlined,
                      ),
                      SizedBox(height: 12.h),
                      _buildNotificationTile(
                        "Push Notifications",
                        "Receive notifications on your device",
                        Icons.notifications_active,
                        provider.pushNotifications,
                        provider.togglePushNotifications,
                      ),
                      _buildNotificationTile(
                        "Email Notifications",
                        "Receive notifications via email",
                        Icons.email_outlined,
                        provider.emailNotifications,
                        provider.toggleEmailNotifications,
                      ),
                      _buildNotificationTile(
                        "SMS Notifications",
                        "Receive notifications via SMS",
                        Icons.sms_outlined,
                        provider.smsNotifications,
                        provider.toggleSmsNotifications,
                      ),
                      SizedBox(height: 24.h),
                      _buildSectionHeader(
                        "Order & Shopping",
                        Icons.shopping_bag_outlined,
                      ),
                      SizedBox(height: 12.h),
                      _buildNotificationTile(
                        "Order Updates",
                        "Get notified about order status changes",
                        Icons.local_shipping_outlined,
                        provider.notificationsEnabled,
                        provider.toggleNotifications,
                      ),
                      _buildNotificationTile(
                        "Delivery Reminders",
                        "Reminders about upcoming deliveries",
                        Icons.delivery_dining_outlined,
                        provider.deliveryReminders ?? false,
                        provider.toggleDeliveryReminders ?? (v) {},
                      ),
                      _buildNotificationTile(
                        "Price Drops",
                        "Get notified when items in your wishlist go on sale",
                        Icons.trending_down_outlined,
                        provider.priceDrops ?? false,
                        provider.togglePriceDrops ?? (v) {},
                      ),
                      SizedBox(height: 24.h),
                      _buildSectionHeader(
                        "Content & Updates",
                        Icons.content_copy_outlined,
                      ),
                      SizedBox(height: 12.h),
                      _buildNotificationTile(
                        "New Products",
                        "Be the first to know about new plant arrivals",
                        Icons.new_releases_outlined,
                        provider.newProducts ?? false,
                        provider.toggleNewProducts ?? (v) {},
                      ),
                      _buildNotificationTile(
                        "Plant Care Tips",
                        "Weekly tips for better plant care",
                        Icons.eco_outlined,
                        provider.plantCareTips ?? false,
                        provider.togglePlantCareTips ?? (v) {},
                      ),
                      _buildNotificationTile(
                        "App Updates",
                        "Important app updates and maintenance",
                        Icons.system_update_outlined,
                        provider.appUpdates ?? false,
                        provider.toggleAppUpdates ?? (v) {},
                      ),
                      SizedBox(height: 24.h),
                      _buildSectionHeader(
                        "Promotional",
                        Icons.local_offer_outlined,
                      ),
                      SizedBox(height: 12.h),
                      _buildNotificationTile(
                        "Promotional Offers",
                        "Special discounts and promotional offers",
                        Icons.discount_outlined,
                        provider.promotionalOffers ?? false,
                        provider.togglePromotionalOffers ?? (v) {},
                      ),
                    ],
                  ),
            ),

            SizedBox(height: 24.h),

            // Order & Shopping
            _buildSectionHeader(
              "Order & Shopping",
              Icons.shopping_bag_outlined,
            ),
            SizedBox(height: 12.h),

            _buildNotificationTile(
              "Order Updates",
              "Get notified about order status changes",
              Icons.local_shipping_outlined,
              _orderUpdates,
              (value) => setState(() => _orderUpdates = value),
            ),

            _buildNotificationTile(
              "Delivery Reminders",
              "Reminders about upcoming deliveries",
              Icons.delivery_dining_outlined,
              _deliveryReminders,
              (value) => setState(() => _deliveryReminders = value),
            ),

            _buildNotificationTile(
              "Price Drops",
              "Get notified when items in your wishlist go on sale",
              Icons.trending_down_outlined,
              _priceDrops,
              (value) => setState(() => _priceDrops = value),
            ),

            SizedBox(height: 24.h),

            // Content & Updates
            _buildSectionHeader(
              "Content & Updates",
              Icons.content_copy_outlined,
            ),
            SizedBox(height: 12.h),

            _buildNotificationTile(
              "New Products",
              "Be the first to know about new plant arrivals",
              Icons.new_releases_outlined,
              _newProducts,
              (value) => setState(() => _newProducts = value),
            ),

            _buildNotificationTile(
              "Plant Care Tips",
              "Weekly tips for better plant care",
              Icons.eco_outlined,
              _plantCareTips,
              (value) => setState(() => _plantCareTips = value),
            ),

            _buildNotificationTile(
              "App Updates",
              "Important app updates and maintenance",
              Icons.system_update_outlined,
              _appUpdates,
              (value) => setState(() => _appUpdates = value),
            ),

            SizedBox(height: 24.h),

            // Promotional
            _buildSectionHeader("Promotional", Icons.local_offer_outlined),
            SizedBox(height: 12.h),

            _buildNotificationTile(
              "Promotional Offers",
              "Special discounts and promotional offers",
              Icons.discount_outlined,
              _promotionalOffers,
              (value) => setState(() => _promotionalOffers = value),
            ),

            SizedBox(height: 24.h),

            // Notification Schedule
            _buildSectionHeader(
              "Notification Schedule",
              Icons.schedule_outlined,
            ),
            SizedBox(height: 12.h),

            _buildScheduleCard(),

            SizedBox(height: 24.h),

            // Quick Actions
            _buildSectionHeader("Quick Actions", Icons.flash_on_outlined),
            SizedBox(height: 12.h),

            _buildQuickActionButton(
              "Test Notifications",
              Icons.notifications_active_outlined,
              _testNotifications,
            ),

            _buildQuickActionButton(
              "Clear All Notifications",
              Icons.clear_all_outlined,
              _clearAllNotifications,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.primary, size: AppSizes.iconSm),
        SizedBox(width: 12.w),
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildNotificationTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Padding(
        padding: AppSizes.paddingAllSm,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(
                icon,
                color: colorScheme.onSurface,
                size: AppSizes.iconMd,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.bodyMedium),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.mutedText,
                    ),
                  ),
                ],
              ),
            ),
            //switch widget
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: value,
                onChanged: onChanged,
                activeColor: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Padding(
        padding: AppSizes.paddingAllMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quiet Hours", style: textTheme.titleLarge),
            SizedBox(height: 12.h),
            Text(
              "Notifications will be silenced during quiet hours (10:00 PM - 8:00 AM)",
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _buildTimePicker(
                    "Start Time",
                    "10:00 PM",
                    () => _selectStartTime(),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildTimePicker(
                    "End Time",
                    "8:00 AM",
                    () => _selectEndTime(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker(String label, String time, VoidCallback onTap) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.bodySmall),
        SizedBox(height: 8.h),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outline),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time, style: textTheme.bodyMedium),
                Icon(
                  Icons.access_time,
                  size: AppSizes.iconSm,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      elevation: 1,

      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),

      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        leading: ProfileCustomIcon(
          icon: icon,
          iconColor: colorScheme.onSurface,
        ),
        title: Text(title, style: textTheme.titleMedium),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: AppSizes.iconXs,
          color: colorScheme.onSurface,
        ),
        onTap: onTap,
      ),
    );
  }

  void _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 22, minute: 0),
    );
    if (picked != null) {
      CustomSnackBar.showInfo(
        context,
        "Start time updated to ${picked.format(context)}",
      );
    }
  }

  void _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0),
    );
    if (picked != null) {
      CustomSnackBar.showInfo(
        context,
        "End time updated to ${picked.format(context)}",
      );
    }
  }

  void _testNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Test notification sent!'),
        action: SnackBarAction(label: 'Dismiss', onPressed: () {}),
      ),
    );
  }

  void _clearAllNotifications() {
    CustomDialog.showConfirmation(
      context: context,
      title: 'Clear All Notifications',
      content:
          'Are you sure you want to clear all notifications? This action cannot be undone.',
      confirmText: 'Clear All',
      cancelText: 'Cancel',
      icon: Icons.clear_all_outlined,
      iconColor: Theme.of(context).colorScheme.primary,
      onConfirm: () {
        CustomSnackBar.showSuccess(context, "All notifications cleared!");
      },
    );
  }

  void _savePreferences() {
    CustomSnackBar.showSuccess(
      context,
      "Notification preferences saved successfully!",
    );
    Navigator.pop(context);
  }
}
