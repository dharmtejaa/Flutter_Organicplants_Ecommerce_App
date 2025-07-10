# Organic Plants App - Widget Colors Documentation

## Overview
This document provides a comprehensive list of all widgets in the Organic Plants Flutter application and their color usage patterns. The app uses a combination of theme-based colors, custom AppColors, and direct Colors references.

## Color Sources

### 1. Theme-Based Colors
- `Theme.of(context).colorScheme.*` - Material 3 color scheme
- `Theme.of(context).textTheme.*` - Text styling with theme colors

### 2. Custom App Colors
- `AppColors.*` - Custom color definitions in `lib/core/theme/appcolors.dart`
- `AppTheme.*` - Theme-specific colors in `lib/core/theme/app_theme.dart`

### 3. Direct Colors
- `Colors.*` - Direct Flutter color references

## Widget Categories and Color Usage

### 🎨 Shared Widgets

#### 1. ProductCard (`lib/shared/widgets/productcard.dart`)
**Colors Used:**
- `colorScheme.surfaceContainerHighest` - Card background
- `colorScheme.shadow.withValues(alpha: 0.1)` - Card shadow
- `colorScheme.surfaceContainerHighest.withValues(alpha: 0.3/0.1)` - Gradient colors
- `colorScheme.onSurfaceVariant` - Error icon color
- `colorScheme.primary` - Star rating color
- `colorScheme.shadow.withValues(alpha: 0.2)` - Button shadow

#### 2. PlantSectionWidget (`lib/shared/widgets/plant_section_widget.dart`)
**Colors Used:**
- `colorScheme.surface` - Container background
- `colorScheme.shadow.withValues(alpha: 0.1)` - Shadow
- `colorScheme.primary` - "See All" button color

#### 3. PlantCardGrid (`lib/shared/widgets/plant_card_grid.dart`)
**Colors Used:**
- Theme-based colors for grid layout

#### 4. PlantCategory (`lib/shared/widgets/plantcategory.dart`)
**Colors Used:**
- Theme-based colors for category display

#### 5. NoResultFound (`lib/shared/widgets/no_result_found.dart`)
**Colors Used:**
- Theme-based colors for empty state

#### 6. SkipButton (`lib/shared/widgets/skip_button.dart`)
**Colors Used:**
- Theme-based colors for skip functionality

### 🔘 Shared Buttons

#### 1. CustomButton (`lib/shared/buttons/custombutton.dart`)
**Colors Used:**
- `backgroundColor` - Custom background color (parameter)
- `textColor ?? colorScheme.onPrimary` - Text/loading indicator color
- `textTheme.labelLarge` - Text styling

#### 2. AddToCartButton (`lib/shared/buttons/add_to_cart_button.dart`)
**Colors Used:**
- Theme-based colors for cart functionality

#### 3. CartIconWithBadge (`lib/shared/buttons/cart_icon_with_batdge.dart`)
**Colors Used:**
- Theme-based colors for cart icon and badge

#### 4. WishlistIconButton (`lib/shared/buttons/wishlist_icon_button.dart`)
**Colors Used:**
- Theme-based colors for wishlist functionality

#### 5. WishlistIconWithBadge (`lib/shared/buttons/wishlist_icon_with_badge.dart`)
**Colors Used:**
- Theme-based colors for wishlist icon and badge

#### 6. SearchButton (`lib/shared/buttons/searchbutton.dart`)
**Colors Used:**
- Theme-based colors for search functionality

### 🏠 Home Feature Widgets

#### 1. HomeScreen (`lib/features/home/presentation/screens/home_screen.dart`)
**Colors Used:**
- Theme-based colors for home screen layout

#### 2. SearchByCategory (`lib/features/home/presentation/widgets/search_by_category.dart`)
**Colors Used:**
- `colorScheme.surface` - Container background
- `colorScheme.surfaceContainerHighest` - Container background
- `colorScheme.shadow.withOpacity(0.10)` - Shadow
- `colorScheme.primary.withOpacity(0.5)` - Selected border
- `colorScheme.outline.withOpacity(0.13)` - Unselected border
- `colorScheme.shadow.withOpacity(0.06)` - Icon shadow
- `colorScheme.onSurface` - Text color
- **Direct Colors:**
  - `Colors.greenAccent, Colors.green` - Category gradients
  - `Colors.lightBlueAccent, Colors.blue`
  - `Colors.orangeAccent, Colors.deepOrange`
  - `Colors.purpleAccent, Colors.purple`
  - `Colors.tealAccent, Colors.teal`
  - `Colors.amberAccent, Colors.amber`
  - `Colors.pinkAccent, Colors.pink`
  - `Colors.limeAccent, Colors.lime`

#### 3. AutoBannerWithNotifier (`lib/features/home/presentation/widgets/auto_banner_with_notifier.dart`)
**Colors Used:**
- Theme-based colors for banner display

### 🛍️ Product Feature Widgets

#### 1. ProductScreen (`lib/features/product/presentation/screens/product_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.green.withOpacity(0.12)` - In stock background
  - `Colors.red.withOpacity(0.12)` - Out of stock background
  - `Colors.green` - In stock border/text
  - `Colors.red` - Out of stock border/text

#### 2. PlantDetails (`lib/features/product/presentation/widgets/plant_details.dart`)
**Colors Used:**
- Theme-based colors for plant information

#### 3. CareGuideSection (`lib/features/product/presentation/widgets/care_guide_section.dart`)
**Colors Used:**
- `AppColors.info` - Watering icon color
- `AppColors.warning` - Temperature icon color
- `AppColors.secondaryOrange` - Humidity icon color
- `AppColors.primaryGreen` - Fertilizer icon color
- `AppColors.info.withOpacity(0.12)` - Watering background
- `AppColors.warning.withOpacity(0.12)` - Temperature background
- `AppColors.secondaryOrange.withOpacity(0.12)` - Humidity background
- `AppColors.primaryGreen.withOpacity(0.12)` - Fertilizer background

#### 4. QuickGuideCard (`lib/features/product/presentation/widgets/quick_guide_table.dart`)
**Colors Used:**
- `colorScheme.primary` - Height icon color
- `colorScheme.secondary` - Width icon color
- `colorScheme.primaryContainer` - Height background
- `colorScheme.secondaryContainer` - Width background
- **Direct Colors:**
  - `Colors.amber` - Sunlight icon color
  - `Colors.green` - Growth rate icon color
  - `Colors.amber.shade50` - Sunlight background
  - `Colors.green.shade50` - Growth rate background

#### 5. ProductFeatureCard (`lib/features/product/presentation/widgets/product_feature_card.dart`)
**Colors Used:**
- Theme-based colors for feature display

#### 6. FAQSection (`lib/features/product/presentation/widgets/faq_section.dart`)
**Colors Used:**
- Theme-based colors for FAQ display

#### 7. IndividualExpansionTile (`lib/features/product/presentation/widgets/individual_expansion_tile.dart`)
**Colors Used:**
- Theme-based colors for expansion tiles

#### 8. DeliveryCheckWidget (`lib/features/product/presentation/widgets/delivary_check_widget.dart`)
**Colors Used:**
- `AppTheme.darkCard` - Dark mode card background
- `AppTheme.lightCard` - Light mode card background
- `colorScheme.surface` - Dark mode border
- `Color(0xFFF0F0F0)` - Light mode border

### 🛒 Cart Feature Widgets

#### 1. CartScreen (`lib/features/cart/presentation/screens/cart_screen.dart`)
**Colors Used:**
- Theme-based colors for cart display

#### 2. CheckoutScreen (`lib/features/cart/presentation/screens/checkout_screen.dart`)
**Colors Used:**
- Theme-based colors for checkout process

#### 3. CartTile (`lib/features/cart/presentation/widgets/card_tile.dart`)
**Colors Used:**
- Theme-based colors for cart item display

#### 4. CartBottomSheet (`lib/features/cart/presentation/widgets/cart_bottom_sheet.dart`)
**Colors Used:**
- `colorScheme.surface` - Container background
- `colorScheme.primary` - Checkout button background
- **Direct Colors:**
  - `Colors.red` - Discount color (parameter)

### 👤 Profile Feature Widgets

#### 1. ProfileScreen (`lib/features/profile/presentation/screens/profile_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.blue` - My Orders icon
  - `Colors.green` - Wishlist icon
  - `Colors.orange` - Reviews icon
  - `Colors.purple` - Addresses icon
  - `Colors.indigo` - Payment Methods icon
  - `Colors.teal` - Plant Care Guide icon
  - `Colors.amber` - Rate App icon
  - `Colors.lightGreen` - Share App icon
  - `Colors.blue` - Customer Support icon
  - `Colors.grey` - FAQ icon
  - `Colors.cyan` - About Us icon
  - `Colors.deepPurple` - Terms of Service icon

#### 2. ProfileHeaderCard (`lib/features/profile/presentation/widgets/profile_header_card.dart`)
**Colors Used:**
- Theme-based colors for profile header

#### 3. ProfileMenuItem (`lib/features/profile/presentation/widgets/profile_menu_item.dart`)
**Colors Used:**
- `colorScheme.surfaceContainerHighest` - Menu item background
- `colorScheme.shadow.withValues(alpha: 0.05)` - Shadow
- `Colors.transparent` - Background color option

#### 4. QuickActionsGrid (`lib/features/profile/presentation/widgets/quick_actions_grid.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.blue` - My Orders card
  - `Colors.red` - Wishlist card
  - `Colors.orange` - Reviews card
  - `Colors.purple` - Addresses card
  - `Colors.transparent` - Card background

#### 5. OrderHistoryScreen (`lib/features/profile/presentation/screens/order_history_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.red` - Cancel button background
  - `Colors.white` - Cancel button text
  - `Colors.green` - Delivered status
  - `Colors.blue` - In transit status
  - `Colors.red` - Cancelled status
  - `Colors.orange` - Returned status
  - `Colors.white` - Status text

#### 6. OrderDetailsScreen (`lib/features/profile/presentation/screens/order_details_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.green` - Delivered status
  - `Colors.blue` - In transit status
  - `Colors.red` - Cancelled status
  - `Colors.orange` - Returned status
  - `Colors.white` - Status text

#### 7. TrackOrdersScreen (`lib/features/profile/presentation/screens/track_orders_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.orange` - Processing status
  - `Colors.blue` - In transit status
  - `Colors.green` - Out for delivery/delivered status
  - `Colors.grey` - Default status

#### 8. CustomerSupportScreen (`lib/features/profile/presentation/screens/customer_support_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.blue` - Live Chat, Order Issues, Account Issues
  - `Colors.green` - Email Support, Plant Care, WhatsApp
  - `Colors.orange` - Call Us, Payment Problems
  - `Colors.purple` - Delivery Issues
  - `Colors.red` - Returns & Refunds
  - `Colors.indigo` - Account Issues
  - `Colors.white` - Button text
  - `Colors.transparent` - Container background

#### 9. FAQScreen (`lib/features/profile/presentation/screens/faq_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.green` - Plant Care category
  - `Colors.blue` - Shipping category
  - `Colors.orange` - Returns category
  - `Colors.purple` - Payment category
  - `Colors.indigo` - Orders category
  - `Colors.teal` - Support category
  - `Colors.grey` - Default category
  - `Colors.transparent` - Container background

#### 10. PlantCareGuideScreen (`lib/features/profile/presentation/screens/plant_care_guide_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.blue` - Watering category
  - `Colors.orange` - Lighting category
  - `Colors.brown` - Soil category
  - `Colors.green` - Fertilizing category
  - `Colors.purple` - Pruning category
  - `Colors.red` - Pest Control category
  - `Colors.amber` - Lightbulb icon
  - `Colors.green` - Check circle icon
  - `Colors.red` - Emergency icon
  - `Colors.transparent` - Container background

#### 11. PaymentMethodsScreen (`lib/features/profile/presentation/screens/payment_methods_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.blue` - Credit/Debit Card
  - `Colors.purple` - UPI
  - `Colors.green` - Net Banking
  - `Colors.orange` - Cash on Delivery
  - `Colors.red` - Delete button text
  - `Colors.transparent` - Container background

#### 12. ReturnsRefundsScreen (`lib/features/profile/presentation/screens/returns_refunds_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.orange` - Processing status
  - `Colors.green` - Refunded status
  - `Colors.red` - Cancelled status
  - `Colors.grey` - Default status
  - `Colors.transparent` - Container background

#### 13. MyReviewsScreen (`lib/features/profile/presentation/screens/my_reviews_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.amber` - Star rating
  - `Colors.transparent` - Container background

#### 14. RateAppScreen (`lib/features/profile/presentation/screens/rate_app_screen.dart`)
**Colors Used:**
- **Direct Colors:**
  - `Colors.amber` - Star rating
  - `Colors.transparent` - Container background

### 🔍 Search Feature Widgets

#### 1. SearchScreen (`lib/features/search/presentation/screens/search_screen.dart`)
**Colors Used:**
- Theme-based colors for search functionality

#### 2. SearchField (`lib/features/search/presentation/widgets/search_field.dart`)
**Colors Used:**
- Theme-based colors for search input

#### 3. SectionHeader (`lib/features/search/presentation/widgets/section_header.dart`)
**Colors Used:**
- Theme-based colors for section headers

#### 4. EmptyMessage (`lib/features/search/presentation/widgets/empty_message.dart`)
**Colors Used:**
- Theme-based colors for empty state

### ❤️ Wishlist Feature Widgets

#### 1. WishlistScreen (`lib/features/wishlist/presentation/screens/wishlist_screen.dart`)
**Colors Used:**
- Theme-based colors for wishlist display

#### 2. ProductTile (`lib/features/wishlist/presentation/widgets/product_tile.dart`)
**Colors Used:**
- `colorScheme.surface` - Container background
- **Direct Colors:**
  - `Colors.black.withOpacity(0.1)` - Dark mode shadow
  - `Colors.grey.withOpacity(0.1)` - Light mode shadow

### 🏪 Store Feature Widgets

#### 1. StoreScreen (`lib/features/store/presentation/screen/store_screen.dart`)
**Colors Used:**
- Theme-based colors for store display

### 🎬 Onboarding Feature Widgets

#### 1. OnboardingScreen (`lib/features/onboarding/presentation/screens/onboarding_screen.dart`)
**Colors Used:**
- `AppColors.background` - Icon color

### 🔐 Auth Feature Widgets

#### 1. LoginScreen (`lib/features/auth/presentation/screens/loginscreen.dart`)
**Colors Used:**
- Theme-based colors for login form

#### 2. OTPScreen (`lib/features/auth/presentation/screens/otpscreen.dart`)
**Colors Used:**
- Theme-based colors for OTP input

#### 3. BasicDetails (`lib/features/auth/presentation/screens/basicdetails.dart`)
**Colors Used:**
- Theme-based colors for user details form

#### 4. CustomTextField (`lib/features/auth/presentation/widgets/custom_textfield.dart`)
**Colors Used:**
- Theme-based colors for text input

#### 5. CustomRichText (`lib/features/auth/presentation/widgets/custom_rich_text.dart`)
**Colors Used:**
- Theme-based colors for rich text

#### 6. TermsAndPolicyText (`lib/features/auth/presentation/widgets/terms_and_policy_text.dart`)
**Colors Used:**
- Theme-based colors for terms text

### 🎭 Entry Feature Widgets

#### 1. EntryScreen (`lib/features/entry/presentation/screen/entry_screen.dart`)
**Colors Used:**
- Theme-based colors for entry navigation

### 🌟 Splash Feature Widgets

#### 1. SplashScreen (`lib/features/splash/presentation/screens/splashscreen.dart`)
**Colors Used:**
- Theme-based colors for splash screen

### 🎨 Shared Logic Widgets

#### 1. CustomSnackBar (`lib/shared/widgets/custom_snackbar.dart`)
**Colors Used:**
- `AppColors.success` - Success snackbar background
- `AppColors.error` - Error snackbar background
- `AppColors.info` - Info snackbar background
- `AppColors.warning` - Warning snackbar background

## Color Usage Patterns

### 1. Theme-Based Approach (Recommended)
Most widgets use `Theme.of(context).colorScheme.*` for consistent theming:
- `colorScheme.primary` - Primary actions
- `colorScheme.surface` - Container backgrounds
- `colorScheme.onSurface` - Text colors
- `colorScheme.shadow` - Shadows with opacity

### 2. AppColors Usage
Custom colors defined in `AppColors` class:
- `AppColors.primaryGreen` - Main brand color
- `AppColors.secondaryOrange` - Secondary brand color
- `AppColors.success/error/warning/info` - Status colors

### 3. Direct Colors Usage
Some widgets use direct `Colors.*` references:
- Status indicators (green, red, blue, orange)
- Category colors (blue, green, orange, purple, etc.)
- Rating colors (amber for stars)

## Recommendations

1. **Standardize on Theme Colors**: Replace direct `Colors.*` usage with theme-based colors where possible
2. **Use AppColors for Brand Colors**: Use `AppColors.*` for brand-specific colors
3. **Consistent Status Colors**: Use `AppColors.success/error/warning/info` for status indicators
4. **Theme-Aware Shadows**: Use `colorScheme.shadow.withValues(alpha: X)` for consistent shadows

## File Structure
```
lib/
├── core/theme/
│   ├── appcolors.dart          # Custom color definitions
│   └── app_theme.dart          # Theme configurations
├── shared/
│   ├── widgets/                # Shared UI components
│   └── buttons/                # Shared button components
└── features/
    ├── home/                   # Home screen widgets
    ├── product/                # Product detail widgets
    ├── cart/                   # Cart functionality widgets
    ├── profile/                # Profile management widgets
    ├── search/                 # Search functionality widgets
    ├── wishlist/               # Wishlist widgets
    ├── store/                  # Store widgets
    ├── onboarding/             # Onboarding widgets
    ├── auth/                   # Authentication widgets
    ├── entry/                  # Entry navigation widgets
    └── splash/                 # Splash screen widgets
``` 