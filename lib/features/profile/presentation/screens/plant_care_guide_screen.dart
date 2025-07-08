import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlantCareGuideScreen extends StatefulWidget {
  const PlantCareGuideScreen({super.key});

  @override
  State<PlantCareGuideScreen> createState() => _PlantCareGuideScreenState();
}

class _PlantCareGuideScreenState extends State<PlantCareGuideScreen> {
  final List<Map<String, dynamic>> _careGuides = [
    {
      'title': 'Watering Basics',
      'icon': Icons.water_drop_outlined,
      'color': Colors.blue,
      'description': 'Learn the fundamentals of proper plant watering',
      'content': [
        'Water when the top 1-2 inches of soil feels dry',
        'Use room temperature water',
        'Water thoroughly until it drains from the bottom',
        'Avoid overwatering - it\'s the most common cause of plant death',
      ],
    },
    {
      'title': 'Light Requirements',
      'icon': Icons.wb_sunny_outlined,
      'color': Colors.orange,
      'description': 'Understanding your plant\'s light needs',
      'content': [
        'Direct sunlight: 6+ hours of direct sun',
        'Bright indirect light: Near a sunny window',
        'Medium light: 3-4 feet from a window',
        'Low light: Can survive in darker corners',
      ],
    },
    {
      'title': 'Soil & Potting',
      'icon': Icons.eco_outlined,
      'color': Colors.brown,
      'description': 'Choosing the right soil and containers',
      'content': [
        'Use well-draining potting mix',
        'Choose pots with drainage holes',
        'Repot when roots outgrow the container',
        'Use appropriate pot size for your plant',
      ],
    },
    {
      'title': 'Temperature & Humidity',
      'icon': Icons.thermostat_outlined,
      'color': Colors.green,
      'description': 'Creating the ideal environment',
      'content': [
        'Most houseplants prefer 65-75°F (18-24°C)',
        'Avoid cold drafts and hot air vents',
        'Increase humidity with humidifiers or pebble trays',
        'Group plants together to create microclimates',
      ],
    },
    {
      'title': 'Fertilizing',
      'icon': Icons.grass_outlined,
      'color': Colors.purple,
      'description': 'Feeding your plants properly',
      'content': [
        'Fertilize during growing season (spring/summer)',
        'Use balanced, water-soluble fertilizer',
        'Dilute to half strength for most plants',
        'Reduce or stop fertilizing in winter',
      ],
    },
    {
      'title': 'Pruning & Maintenance',
      'icon': Icons.content_cut_outlined,
      'color': Colors.red,
      'description': 'Keeping your plants healthy and beautiful',
      'content': [
        'Remove dead or yellowing leaves',
        'Prune to encourage bushier growth',
        'Clean leaves regularly to remove dust',
        'Check for pests and diseases weekly',
      ],
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
          "Plant Care Guide",
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
          IconButton(
            icon: Icon(Icons.search, color: colorScheme.onSurface),
            onPressed: _searchCareGuides,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              padding: EdgeInsets.all(20.w),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.eco_rounded,
                        size: 32.r,
                        color: colorScheme.onPrimaryContainer,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          "Welcome to Plant Care",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Learn essential tips and tricks to keep your plants healthy and thriving. Whether you're a beginner or experienced gardener, we have everything you need to know.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Care Guides Grid
            Text(
              "Care Topics",
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
                childAspectRatio: 0.85,
              ),
              itemCount: _careGuides.length,
              itemBuilder: (context, index) {
                return _buildCareGuideCard(_careGuides[index]);
              },
            ),

            SizedBox(height: 24.h),

            // Quick Tips Section
            _buildQuickTipsSection(),

            SizedBox(height: 24.h),

            // Emergency Care Section
            _buildEmergencyCareSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCareGuideCard(Map<String, dynamic> guide) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: InkWell(
        onTap: () => _showCareGuideDetails(guide),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: guide['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(guide['icon'], color: guide['color'], size: 24.r),
              ),
              SizedBox(height: 12.h),
              Text(
                guide['title'],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                guide['description'],
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    "Learn More",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: guide['color'],
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12.r,
                    color: guide['color'],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickTipsSection() {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.amber, size: 24.r),
                SizedBox(width: 8.w),
                Text(
                  "Quick Tips",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildQuickTip("Rotate your plants weekly for even growth"),
            _buildQuickTip("Use filtered or rainwater for sensitive plants"),
            _buildQuickTip(
              "Keep a care journal to track your plant's progress",
            ),
            _buildQuickTip("Group plants with similar care needs together"),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickTip(String tip) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, size: 16.r, color: Colors.green),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(fontSize: 14.sp, color: colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyCareSection() {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emergency_outlined, color: Colors.red, size: 24.r),
                SizedBox(width: 8.w),
                Text(
                  "Emergency Care",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildEmergencyTip(
              "Overwatered Plant",
              "Remove from pot, let roots dry, repot in fresh soil",
              Icons.water_drop_outlined,
            ),
            _buildEmergencyTip(
              "Underwatered Plant",
              "Soak in water for 30 minutes, then resume normal watering",
              Icons.dry_outlined,
            ),
            _buildEmergencyTip(
              "Pest Infestation",
              "Isolate plant, treat with neem oil or insecticidal soap",
              Icons.bug_report_outlined,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _contactSupport,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48.h),
              ),
              child: Text("Contact Plant Expert"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyTip(String title, String solution, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.r, color: Colors.red),
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
                SizedBox(height: 2.h),
                Text(
                  solution,
                  style: TextStyle(
                    fontSize: 12.sp,
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

  void _showCareGuideDetails(Map<String, dynamic> guide) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                // Handle
                Container(
                  margin: EdgeInsets.only(top: 12.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: colorScheme.outline,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),

                // Header
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: guide['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          guide['icon'],
                          color: guide['color'],
                          size: 24.r,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              guide['title'],
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              guide['description'],
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
                ),

                // Content
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: guide['content'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 6.h),
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                color: guide['color'],
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                guide['content'][index],
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _searchCareGuides() {
    // TODO: Implement search functionality
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Search feature coming soon!')));
  }

  void _contactSupport() {
    // TODO: Navigate to support screen
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Contacting plant expert...')));
  }
}
