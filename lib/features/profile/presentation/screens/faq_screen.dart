import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'How do I care for my new plant?',
      'answer':
          'Most plants need bright, indirect light, regular watering when the top soil feels dry, and well-draining soil. Check the care guide that comes with your plant for specific instructions.',
      'category': 'Plant Care',
      'icon': Icons.eco_outlined,
    },
    {
      'question': 'What is your return policy?',
      'answer':
          'We offer a 30-day return window for all plants. If your plant arrives damaged or dies within 30 days, we\'ll replace it or provide a full refund.',
      'category': 'Returns',
      'icon': Icons.assignment_return_outlined,
    },
    {
      'question': 'How long does shipping take?',
      'answer':
          'Standard shipping takes 3-5 business days. Express shipping (1-2 days) is available for an additional fee. We ship plants carefully packaged to ensure they arrive healthy.',
      'category': 'Shipping',
      'icon': Icons.local_shipping_outlined,
    },
    {
      'question': 'Do you ship internationally?',
      'answer':
          'Currently, we only ship within India. We\'re working on expanding our shipping to other countries soon.',
      'category': 'Shipping',
      'icon': Icons.local_shipping_outlined,
    },
    {
      'question': 'Are your plants pet-safe?',
      'answer':
          'We offer a selection of pet-safe plants. Look for the "Pet Safe" badge on plant listings. However, we recommend keeping all plants out of reach of pets.',
      'category': 'Plant Care',
      'icon': Icons.eco_outlined,
    },
    {
      'question': 'What payment methods do you accept?',
      'answer':
          'We accept all major credit/debit cards, UPI, net banking, and digital wallets like Paytm, PhonePe, and Google Pay.',
      'category': 'Payment',
      'icon': Icons.payment_outlined,
    },
    {
      'question': 'Can I cancel my order?',
      'answer':
          'You can cancel your order within 2 hours of placing it. After that, the order will be processed and shipped. Contact our support team for assistance.',
      'category': 'Orders',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'question': 'Do you offer plant care advice?',
      'answer':
          'Yes! We provide detailed care guides with each plant, and our plant care experts are available via chat, email, or phone to help you with any questions.',
      'category': 'Support',
      'icon': Icons.support_agent_outlined,
    },
  ];

  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredFaqs = [];

  @override
  void initState() {
    super.initState();
    _filteredFaqs = _faqs;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "FAQ",
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
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  onChanged: _filterFaqs,
                  decoration: InputDecoration(
                    hintText: 'Search FAQs...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: colorScheme.outline),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: colorScheme.outline),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest,
                  ),
                ),

                SizedBox(height: 16.h),

                // Category Filter
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryChip('All'),
                      SizedBox(width: 8.w),
                      _buildCategoryChip('Plant Care'),
                      SizedBox(width: 8.w),
                      _buildCategoryChip('Shipping'),
                      SizedBox(width: 8.w),
                      _buildCategoryChip('Returns'),
                      SizedBox(width: 8.w),
                      _buildCategoryChip('Payment'),
                      SizedBox(width: 8.w),
                      _buildCategoryChip('Orders'),
                      SizedBox(width: 8.w),
                      _buildCategoryChip('Support'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // FAQ List
          Expanded(
            child:
                _filteredFaqs.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: _filteredFaqs.length,
                      itemBuilder: (context, index) {
                        return _buildFAQCard(_filteredFaqs[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = _selectedCategory == category;

    return FilterChip(
      label: Text(
        category,
        style: TextStyle(
          color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedCategory = category;
          _filterFaqs(_searchController.text);
        });
      },
      backgroundColor: colorScheme.surface,
      selectedColor: colorScheme.primary,
      checkmarkColor: colorScheme.onPrimary,
      side: BorderSide(color: colorScheme.outline),
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_outlined,
              size: 64.r,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "No FAQs Found",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Try adjusting your search or filter",
            style: TextStyle(
              fontSize: 16.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFAQCard(Map<String, dynamic> faq) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 2,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: ExpansionTile(
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: _getCategoryColor(faq['category']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            faq['icon'],
            color: _getCategoryColor(faq['category']),
            size: 20.r,
          ),
        ),
        title: Text(
          faq['question'],
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: _getCategoryColor(faq['category']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              faq['category'],
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: _getCategoryColor(faq['category']),
              ),
            ),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
            child: Text(
              faq['answer'],
              style: TextStyle(
                fontSize: 14.sp,
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Plant Care':
        return Colors.green;
      case 'Shipping':
        return Colors.blue;
      case 'Returns':
        return Colors.orange;
      case 'Payment':
        return Colors.purple;
      case 'Orders':
        return Colors.indigo;
      case 'Support':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  void _filterFaqs(String query) {
    setState(() {
      _filteredFaqs =
          _faqs.where((faq) {
            final matchesSearch =
                faq['question'].toLowerCase().contains(query.toLowerCase()) ||
                faq['answer'].toLowerCase().contains(query.toLowerCase());
            final matchesCategory =
                _selectedCategory == 'All' ||
                faq['category'] == _selectedCategory;
            return matchesSearch && matchesCategory;
          }).toList();
    });
  }
}
