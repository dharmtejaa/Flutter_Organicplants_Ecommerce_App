import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/models/all_plants_model.dart';

class FAQSection extends StatelessWidget {
  final AllPlantsModel plant;

  const FAQSection({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final faqs = plant.faqs;
    if (faqs == null) return const SizedBox();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final faq = faqs[index];
        return _FAQCard(
          question: faq.question ?? '',
          answer: faq.answer ?? '',
          color: colorScheme.primary,
          bgColor: colorScheme.primaryContainer.withOpacity(0.15),
        );
      },
    );
  }
}

class _FAQCard extends StatelessWidget {
  final String question;
  final String answer;
  final Color color;
  final Color bgColor;
  _FAQCard({
    required this.question,
    required this.answer,
    required this.color,
    required this.bgColor,
  });
  final ValueNotifier<bool> expandedNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: () => expandedNotifier.value = !expandedNotifier.value,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.all(7.r),
                child: Icon(Icons.question_answer, color: color, size: 22.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            question,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: color,
                            ),
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: expandedNotifier,
                          builder:
                              (context, expanded, _) => Icon(
                                expanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: color,
                                size: 20.r,
                              ),
                        ),
                      ],
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: expandedNotifier,
                      builder:
                          (context, expanded, _) => AnimatedCrossFade(
                            firstChild: SizedBox.shrink(),
                            secondChild: Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Text(
                                answer,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            crossFadeState:
                                expanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                            duration: Duration(milliseconds: 250),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
