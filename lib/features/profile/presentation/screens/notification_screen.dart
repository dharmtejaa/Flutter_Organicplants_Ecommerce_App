import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Order Shipped',
        'body': 'Your order #1234 has been shipped!',
        'time': '2 hours ago',
      },
      {
        'title': 'Welcome!',
        'body': 'Thank you for joining Organic Plants.',
        'time': '1 day ago',
      },
      {
        'title': 'Discount Offer',
        'body': 'Get 10% off on your next purchase.',
        'time': '3 days ago',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Colors.green),
              title: Text(notification['title']!),
              subtitle: Text(notification['body']!),
              trailing: Text(
                notification['time']!,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
          );
        },
      ),
    );
  }
}
