# Organic Plants App - Sizing Guide

## Overview
This guide explains how to use the centralized sizing system in the Organic Plants app. All font sizes, padding, margins, border radius, and other dimensions should use the `AppSizes` class instead of hardcoded values.

## Why Use AppSizes?
- **Consistency**: All UI elements follow the same sizing scale
- **Maintainability**: Change sizes in one place, affects entire app
- **Responsiveness**: Sizes automatically adapt to different screen sizes
- **Theme Support**: Sizes work with both light and dark themes

## File Location
```
lib/core/services/app_sizes.dart
```

## How to Use

### 1. Import AppSizes
```dart
import 'package:organicplants/core/services/app_sizes.dart';
```

### 2. Font Sizes
```dart
// ❌ Don't do this
Text(
  'Hello World',
  style: TextStyle(fontSize: 16.sp),
)

// ✅ Do this instead
Text(
  'Hello World',
  style: TextStyle(fontSize: AppSizes.fontMd),
)
```

**Available Font Sizes:**
- `AppSizes.fontUxs` = 10.sp (Ultra Extra Small)
- `AppSizes.fontXs` = 12.sp (Extra Small)
- `AppSizes.fontSm` = 14.sp (Small)
- `AppSizes.fontMd` = 16.sp (Medium)
- `AppSizes.fontLg` = 18.sp (Large)
- `AppSizes.fontXl` = 20.sp (Extra Large)
- `AppSizes.fontXxl` = 24.sp (Extra Extra Large)
- `AppSizes.fontDisplay` = 32.sp (Display)

### 3. Icon Sizes
```dart
// ❌ Don't do this
Icon(Icons.home, size: 24.sp)

// ✅ Do this instead
Icon(Icons.home, size: AppSizes.iconMd)
```

**Available Icon Sizes:**
- `AppSizes.iconXs` = 16.sp
- `AppSizes.iconSm` = 20.sp
- `AppSizes.iconMd` = 24.sp
- `AppSizes.iconLg` = 32.sp
- `AppSizes.iconXl` = 48.sp

### 4. Padding
```dart
// ❌ Don't do this
Container(
  padding: EdgeInsets.all(16.w),
  child: Text('Content'),
)

// ✅ Do this instead
Container(
  padding: AppSizes.paddingAllMd,
  child: Text('Content'),
)
```

**Available Padding:**
- Individual: `AppSizes.paddingXs`, `AppSizes.paddingSm`, `AppSizes.paddingMd`, `AppSizes.paddingLg`, `AppSizes.paddingXl`, `AppSizes.paddingXxl`
- Vertical: `AppSizes.vPaddingXs`, `AppSizes.vPaddingSm`, `AppSizes.vPaddingMd`, `AppSizes.vPaddingLg`, `AppSizes.vPaddingXl`, `AppSizes.vPaddingXxl`
- Pre-built EdgeInsets: `AppSizes.paddingAllXs`, `AppSizes.paddingAllSm`, `AppSizes.paddingAllMd`, `AppSizes.paddingAllLg`, `AppSizes.paddingAllXl`, `AppSizes.paddingAllXxl`
- Symmetric: `AppSizes.paddingSymmetricXs`, `AppSizes.paddingSymmetricSm`, `AppSizes.paddingSymmetricMd`, `AppSizes.paddingSymmetricLg`, `AppSizes.paddingSymmetricXl`, `AppSizes.paddingSymmetricXxl`

### 5. Margins
```dart
// ❌ Don't do this
Container(
  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  child: Text('Content'),
)

// ✅ Do this instead
Container(
  margin: AppSizes.marginSymmetricMd,
  child: Text('Content'),
)
```

**Available Margins:**
- Individual: `AppSizes.marginXs`, `AppSizes.marginSm`, `AppSizes.marginMd`, `AppSizes.marginLg`, `AppSizes.marginXl`, `AppSizes.marginXxl`
- Vertical: `AppSizes.vMarginXs`, `AppSizes.vMarginSm`, `AppSizes.vMarginMd`, `AppSizes.vMarginLg`, `AppSizes.vMarginXl`, `AppSizes.vMarginXxl`
- Pre-built EdgeInsets: `AppSizes.marginAllXs`, `AppSizes.marginAllSm`, `AppSizes.marginAllMd`, `AppSizes.marginAllLg`, `AppSizes.marginAllXl`, `AppSizes.marginAllXxl`
- Symmetric: `AppSizes.marginSymmetricXs`, `AppSizes.marginSymmetricSm`, `AppSizes.marginSymmetricMd`, `AppSizes.marginSymmetricLg`, `AppSizes.marginSymmetricXl`, `AppSizes.marginSymmetricXxl`

### 6. Border Radius
```dart
// ❌ Don't do this
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.r),
  ),
)

// ✅ Do this instead
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(AppSizes.radiusLg),
  ),
)
```

**Available Border Radius:**
- `AppSizes.radiusXs` = 4.r
- `AppSizes.radiusSm` = 8.r
- `AppSizes.radiusMd` = 12.r
- `AppSizes.radiusLg` = 16.r
- `AppSizes.radiusXl` = 20.r
- `AppSizes.radiusXxl` = 24.r
- `AppSizes.radiusCircular` = 50.r

### 7. Spacing
```dart
// ❌ Don't do this
SizedBox(height: 16.h)
SizedBox(width: 8.w)

// ✅ Do this instead
SizedBox(height: AppSizes.spaceMd)
SizedBox(width: AppSizes.spaceSm)
```

**Available Spacing:**
- `AppSizes.spaceXs` = 4.w
- `AppSizes.spaceSm` = 8.w
- `AppSizes.spaceMd` = 16.w
- `AppSizes.spaceLg` = 24.w
- `AppSizes.spaceXl` = 32.w
- `AppSizes.spaceXxl` = 48.w

## Feature-Specific Sizes

### Profile Screen
- `AppSizes.profileAvatarSize` = 80.w
- `AppSizes.profileHeaderPadding` = 20.w
- `AppSizes.profileStatIconSize` = 48.w
- `AppSizes.profileStatIconPadding` = 12.w
- `AppSizes.profileMenuIconSize` = 48.w
- `AppSizes.profileMenuIconPadding` = 12.w

### Authentication
- `AppSizes.authContainerRadius` = 20.r
- `AppSizes.authFieldHeight` = 56.h
- `AppSizes.authFieldRadius` = 16.r
- `AppSizes.authButtonHeight` = 56.h
- `AppSizes.authButtonRadius` = 16.r

### Product Cards
- `AppSizes.productImageHeight` = 200.h
- `AppSizes.productCardRadius` = 16.r
- `AppSizes.productPriceSize` = 18.sp
- `AppSizes.productTitleSize` = 16.sp
- `AppSizes.productDescriptionSize` = 14.sp

### Cart & Wishlist
- `AppSizes.cartItemHeight` = 120.h
- `AppSizes.cartItemRadius` = 12.r
- `AppSizes.cartQuantityButtonSize` = 32.w
- `AppSizes.cartBottomSheetRadius` = 20.r
- `AppSizes.wishlistItemHeight` = 160.h
- `AppSizes.wishlistItemRadius` = 16.r
- `AppSizes.wishlistIconSize` = 24.w

### Onboarding
- `AppSizes.onboardingImageHeight` = 300.h
- `AppSizes.onboardingTitleSize` = 28.sp
- `AppSizes.onboardingSubtitleSize` = 16.sp
- `AppSizes.onboardingDotSize` = 8.w
- `AppSizes.onboardingDotSpacing` = 8.w

### Search
- `AppSizes.searchFieldHeight` = 48.h
- `AppSizes.searchFieldRadius` = 24.r
- `AppSizes.searchResultItemHeight` = 80.h
- `AppSizes.searchResultItemRadius` = 12.r

### Home Screen
- `AppSizes.homeBannerHeight` = 180.h
- `AppSizes.homeCategorySize` = 80.w
- `AppSizes.homeProductCardWidth` = 160.w
- `AppSizes.homeProductCardHeight` = 240.h
- `AppSizes.homeSectionSpacing` = 24.h

## Common UI Elements
- `AppSizes.dividerHeight` = 1.h
- `AppSizes.shadowBlurRadius` = 8.r
- `AppSizes.shadowOffset` = 2.r
- `AppSizes.elevation` = 4.r
- `AppSizes.borderWidth` = 1.w
- `AppSizes.borderWidthThick` = 2.w

## Best Practices

### 1. Always Import AppSizes
```dart
import 'package:organicplants/core/services/app_sizes.dart';
```

### 2. Use Semantic Names
```dart
// ✅ Good - semantic meaning
fontSize: AppSizes.fontMd  // Medium text
padding: AppSizes.paddingAllMd  // Medium padding

// ❌ Avoid - unclear meaning
fontSize: AppSizes.fontXs  // for large headings
padding: AppSizes.paddingAllXs  // for large containers
```

### 3. Be Consistent Within Components
```dart
// ✅ Good - consistent spacing
Column(
  children: [
    Text('Title', style: TextStyle(fontSize: AppSizes.fontLg)),
    SizedBox(height: AppSizes.spaceMd),
    Text('Subtitle', style: TextStyle(fontSize: AppSizes.fontMd)),
    SizedBox(height: AppSizes.spaceSm),
    Text('Body', style: TextStyle(fontSize: AppSizes.fontSm)),
  ],
)
```

### 4. Use Pre-built EdgeInsets When Possible
```dart
// ✅ Good - use pre-built
Container(
  padding: AppSizes.paddingAllMd,
  margin: AppSizes.marginSymmetricMd,
)

// ❌ Avoid - manual construction
Container(
  padding: EdgeInsets.all(AppSizes.paddingMd),
  margin: EdgeInsets.symmetric(
    horizontal: AppSizes.marginMd,
    vertical: AppSizes.vMarginMd,
  ),
)
```

## Migration Checklist

When updating existing code:

1. ✅ Import AppSizes
2. ✅ Replace hardcoded font sizes with AppSizes constants
3. ✅ Replace hardcoded padding with AppSizes constants
4. ✅ Replace hardcoded margins with AppSizes constants
5. ✅ Replace hardcoded border radius with AppSizes constants
6. ✅ Replace hardcoded spacing with AppSizes constants
7. ✅ Replace hardcoded icon sizes with AppSizes constants
8. ✅ Test on different screen sizes
9. ✅ Verify theme compatibility

## Examples

### Profile Header Card
```dart
Container(
  margin: AppSizes.marginSymmetricMd,
  padding: AppSizes.paddingAllLg,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(AppSizes.radiusXl),
  ),
  child: Text(
    'Profile',
    style: TextStyle(fontSize: AppSizes.fontXxl),
  ),
)
```

### Menu Item
```dart
Container(
  margin: AppSizes.marginSymmetricSm,
  padding: AppSizes.paddingAllMd,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(AppSizes.radiusLg),
  ),
  child: Row(
    children: [
      Icon(Icons.home, size: AppSizes.iconMd),
      SizedBox(width: AppSizes.spaceMd),
      Text('Home', style: TextStyle(fontSize: AppSizes.fontMd)),
    ],
  ),
)
```

### Button
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    padding: AppSizes.paddingSymmetricMd,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
    ),
  ),
  child: Text(
    'Submit',
    style: TextStyle(fontSize: AppSizes.fontMd),
  ),
  onPressed: () {},
)
```

## Troubleshooting

### Common Issues

1. **Import Missing**
   ```dart
   // Error: AppSizes is not defined
   // Solution: Add import
   import 'package:organicplants/core/services/app_sizes.dart';
   ```

2. **Wrong Size for Context**
   ```dart
   // Error: Text too small for heading
   // Solution: Use appropriate size
   Text('Heading', style: TextStyle(fontSize: AppSizes.fontLg))  // Instead of fontXs
   ```

3. **Inconsistent Spacing**
   ```dart
   // Error: Inconsistent spacing in list
   // Solution: Use same spacing constant
   Column(
     children: [
       Item1(),
       SizedBox(height: AppSizes.spaceMd),  // Consistent
       Item2(),
       SizedBox(height: AppSizes.spaceMd),  // Consistent
       Item3(),
     ],
   )
   ```

## Summary

- **Always use AppSizes** instead of hardcoded values
- **Import AppSizes** in every file that needs sizing
- **Use semantic names** that match the context
- **Be consistent** within components and across the app
- **Test on different screen sizes** to ensure responsiveness
- **Follow the migration checklist** when updating existing code

This centralized approach ensures a consistent, maintainable, and responsive UI across the entire Organic Plants app. 