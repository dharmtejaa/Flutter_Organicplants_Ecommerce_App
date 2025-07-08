import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({super.key});

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  final List<Map<String, dynamic>> _supportOptions = [
    {
      'title': 'Live Chat',
      'subtitle': 'Chat with our support team',
      'icon': Icons.chat_bubble_outline,
      'color': Colors.blue,
      'action': 'Start Chat',
    },
    {
      'title': 'Email Support',
      'subtitle': 'Send us an email',
      'icon': Icons.email_outlined,
      'color': Colors.green,
      'action': 'Send Email',
    },
    {
      'title': 'Call Us',
      'subtitle': 'Speak with our team',
      'icon': Icons.phone_outlined,
      'color': Colors.orange,
      'action': 'Call Now',
    },
    {
      'title': 'WhatsApp',
      'subtitle': 'Message us on WhatsApp',
      'icon': Icons.chat_bubble_outline,
      'color': Colors.green,
      'action': 'Open WhatsApp',
    },
  ];

  final List<Map<String, dynamic>> _commonIssues = [
    {
      'title': 'Order Issues',
      'icon': Icons.shopping_bag_outlined,
      'color': Colors.blue,
    },
    {'title': 'Plant Care', 'icon': Icons.eco_outlined, 'color': Colors.green},
    {
      'title': 'Payment Problems',
      'icon': Icons.payment_outlined,
      'color': Colors.orange,
    },
    {
      'title': 'Delivery Issues',
      'icon': Icons.local_shipping_outlined,
      'color': Colors.purple,
    },
    {
      'title': 'Returns & Refunds',
      'icon': Icons.assignment_return_outlined,
      'color': Colors.red,
    },
    {
      'title': 'Account Issues',
      'icon': Icons.account_circle_outlined,
      'color': Colors.indigo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Customer Support",
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
            // Header Section
            Container(
              width: double.infinity,
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
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimaryContainer.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.support_agent_rounded,
                      size: 32.r,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "How can we help you?",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Our support team is here to assist you 24/7",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Contact Options
            Text(
              "Contact Options",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 16.h),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.1,
              ),
              itemCount: _supportOptions.length,
              itemBuilder: (context, index) {
                return _buildContactOptionCard(_supportOptions[index]);
              },
            ),

            SizedBox(height: 32.h),

            // Common Issues
            Text(
              "Common Issues",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 16.h),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.2,
              ),
              itemCount: _commonIssues.length,
              itemBuilder: (context, index) {
                return _buildIssueCard(_commonIssues[index]);
              },
            ),

            SizedBox(height: 32.h),

            // Support Hours
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: colorScheme.primary,
                        size: 24.r,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        "Support Hours",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildSupportHourRow("Monday - Friday", "9:00 AM - 8:00 PM"),
                  _buildSupportHourRow("Saturday", "10:00 AM - 6:00 PM"),
                  _buildSupportHourRow("Sunday", "10:00 AM - 4:00 PM"),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: colorScheme.onPrimaryContainer,
                          size: 20.r,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            "Emergency support available 24/7 for urgent plant care issues",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOptionCard(Map<String, dynamic> option) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 3,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: InkWell(
        onTap: () => _handleContactOption(option),
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: option['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(option['icon'], color: option['color'], size: 28.r),
              ),
              SizedBox(height: 12.h),
              Text(
                option['title'],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              Text(
                option['subtitle'],
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: option['color'],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  option['action'],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIssueCard(Map<String, dynamic> issue) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: InkWell(
        onTap: () => _handleIssueTap(issue),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: issue['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(issue['icon'], color: issue['color'], size: 24.r),
              ),
              SizedBox(height: 12.h),
              Text(
                issue['title'],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportHourRow(String day, String hours) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: TextStyle(fontSize: 14.sp, color: colorScheme.onSurface),
          ),
          Text(
            hours,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  void _handleContactOption(Map<String, dynamic> option) {
    switch (option['title']) {
      case 'Live Chat':
        _startLiveChat();
        break;
      case 'Email Support':
        _sendEmail();
        break;
      case 'Call Us':
        _makeCall();
        break;
      case 'WhatsApp':
        _openWhatsApp();
        break;
    }
  }

  void _handleIssueTap(Map<String, dynamic> issue) {
    // TODO: Navigate to specific issue resolution
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening ${issue['title']} help...')),
    );
  }

  void _startLiveChat() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Starting live chat...')));
  }

  void _sendEmail() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Opening email app...')));
  }

  void _makeCall() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Making call...')));
  }

  void _openWhatsApp() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Opening WhatsApp...')));
  }
}
