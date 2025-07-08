import 'package:flutter/material.dart';

import 'package:organicplants/core/services/app_sizes.dart';

class NoResultFound extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onRetry;
  final String? retryText;
  final bool showRetryButton;

  const NoResultFound({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.onRetry,
    this.retryText,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: AppSizes.paddingAllLg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Enhanced Icon with background
            Container(
              padding: AppSizes.paddingAllLg,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.1),
                    blurRadius: AppSizes.shadowBlurRadius,
                    offset: Offset(0, AppSizes.shadowOffset),
                  ),
                ],
              ),
              child: Icon(
                icon ?? Icons.search_off_rounded,
                size: AppSizes.iconXl,
                color: colorScheme.primary,
              ),
            ),

            SizedBox(height: AppSizes.spaceLg),

            // Title
            Text(
              title ?? 'No Results Found',
              style: textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: AppSizes.spaceMd),

            // Subtitle
            Text(
              subtitle ??
                  'Try adjusting your search terms or browse our categories',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            if (showRetryButton && onRetry != null) ...[
              SizedBox(height: AppSizes.spaceXl),

              // Enhanced Retry Button
              Container(
                width: double.infinity,
                height: AppSizes.authButtonHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppSizes.authButtonRadius,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: AppSizes.shadowBlurRadius,
                      offset: Offset(0, AppSizes.shadowOffset),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onRetry,
                    borderRadius: BorderRadius.circular(
                      AppSizes.authButtonRadius,
                    ),
                    child: Container(
                      padding: AppSizes.paddingSymmetricMd,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.refresh_rounded,
                            color: colorScheme.onPrimary,
                            size: AppSizes.iconMd,
                          ),
                          SizedBox(width: AppSizes.spaceMd),
                          Text(
                            retryText ?? 'Try Again',
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
