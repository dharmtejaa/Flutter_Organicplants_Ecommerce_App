import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/shared/widgets/custom_textfield.dart';

class RateAppScreen extends StatefulWidget {
  const RateAppScreen({super.key});

  @override
  State<RateAppScreen> createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  final ValueNotifier<double> _rating = ValueNotifier(0);
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _submitted = ValueNotifier(false);

  @override
  void dispose() {
    _rating.dispose();
    _submitted.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Our App', style: textTheme.headlineMedium),
        
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
            size: AppSizes.iconMd,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: AppSizes.paddingAllSm,
        child: ValueListenableBuilder<bool>(
          valueListenable: _submitted,
          builder: (context, submitted, _) {
            return submitted
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: colorScheme.primary,
                        size: 64.r,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Thank you for your feedback!',
                        style: textTheme.headlineMedium,
                      ),
                    ],
                  ),
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How would you rate our app?',
                      style: textTheme.headlineMedium,
                    ),
                    SizedBox(height: 16.h),
                    ValueListenableBuilder<double>(
                      valueListenable: _rating,
                      builder: (context, rating, _) {
                        return Row(
                          children: List.generate(
                            5,
                            (index) => IconButton(
                              icon: Icon(
                                rating > index ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 32.r,
                              ),
                              onPressed: () => _rating.value = index + 1.0,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    CustomTextField(
                      hintText: 'Additional feedback (optional)',
                      controller: _controller,
                      fillColor: colorScheme.surface,
                      maxLines: 5,
                    ),

                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: ValueListenableBuilder<double>(
                        valueListenable: _rating,
                        builder: (context, rating, _) {
                          return ElevatedButton(
                            onPressed:
                                rating == 0
                                    ? null
                                    : () => _submitted.value = true,
                            child: Text('Submit'),
                          );
                        },
                      ),
                    ),
                  ],
                );
          },
        ),
      ),
    );
  }
}
