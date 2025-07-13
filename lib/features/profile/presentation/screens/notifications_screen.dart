import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:organicplants/shared/logic/theme_provider.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'package:organicplants/shared/widgets/custom_dialog.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final bool _pushNotifications = true;
  final bool _emailNotifications = true;
  final bool _smsNotifications = false;
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

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Notifications",
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
        actions: [
          TextButton(
            onPressed: _savePreferences,
            child: Text(
              "Save",
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
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
                      SizedBox(height: 16.h),
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
                      SizedBox(height: 32.h),
                      _buildSectionHeader(
                        "Order & Shopping",
                        Icons.shopping_bag_outlined,
                      ),
                      SizedBox(height: 16.h),
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
                      SizedBox(height: 32.h),
                      _buildSectionHeader(
                        "Content & Updates",
                        Icons.content_copy_outlined,
                      ),
                      SizedBox(height: 16.h),
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
                      SizedBox(height: 32.h),
                      _buildSectionHeader(
                        "Promotional",
                        Icons.local_offer_outlined,
                      ),
                      SizedBox(height: 16.h),
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

            SizedBox(height: 32.h),

            // Order & Shopping
            _buildSectionHeader(
              "Order & Shopping",
              Icons.shopping_bag_outlined,
            ),
            SizedBox(height: 16.h),

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

            SizedBox(height: 32.h),

            // Content & Updates
            _buildSectionHeader(
              "Content & Updates",
              Icons.content_copy_outlined,
            ),
            SizedBox(height: 16.h),

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

            SizedBox(height: 32.h),

            // Promotional
            _buildSectionHeader("Promotional", Icons.local_offer_outlined),
            SizedBox(height: 16.h),

            _buildNotificationTile(
              "Promotional Offers",
              "Special discounts and promotional offers",
              Icons.discount_outlined,
              _promotionalOffers,
              (value) => setState(() => _promotionalOffers = value),
            ),

            SizedBox(height: 32.h),

            // Notification Schedule
            _buildSectionHeader(
              "Notification Schedule",
              Icons.schedule_outlined,
            ),
            SizedBox(height: 16.h),

            _buildScheduleCard(),

            SizedBox(height: 32.h),

            // Quick Actions
            _buildSectionHeader("Quick Actions", Icons.flash_on_outlined),
            SizedBox(height: 16.h),

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

    return Row(
      children: [
        Icon(icon, color: colorScheme.primary, size: 24.r),
        SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
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

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
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
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard() {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: colorScheme.primary, size: 20.r),
                SizedBox(width: 8.w),
                Text(
                  "Quiet Hours",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              "Notifications will be silenced during quiet hours (10:00 PM - 8:00 AM)",
              style: TextStyle(
                fontSize: 14.sp,
                color: colorScheme.onSurfaceVariant,
              ),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
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
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                Icon(
                  Icons.access_time,
                  size: 16.r,
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

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: colorScheme.onSecondaryContainer,
            size: 20.r,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.r,
          color: colorScheme.onSurfaceVariant,
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
      // TODO: Update start time
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Start time updated to ${picked.format(context)}'),
        ),
      );
    }
  }

  void _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0),
    );
    if (picked != null) {
      // TODO: Update end time
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('End time updated to ${picked.format(context)}'),
        ),
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
      content: 'Are you sure you want to clear all notifications? This action cannot be undone.',
      confirmText: 'Clear All',
      cancelText: 'Cancel',
      icon: Icons.clear_all_outlined,
      iconColor: Theme.of(context).colorScheme.primary,
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('All notifications cleared!')),
        );
      },
    );
  }

  void _savePreferences() {
    // TODO: Save notification preferences to backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notification preferences saved successfully!')),
    );
    Navigator.pop(context);
  }
}
