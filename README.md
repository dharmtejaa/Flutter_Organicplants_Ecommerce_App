# 🌱 Organic Plants - Flutter E-commerce App

A modern, feature-rich Flutter e-commerce application for organic plants, featuring Firebase integration, user authentication, product browsing, cart management, wishlist functionality, and smooth UI animations.

## 📱 App Overview

Organic Plants is a comprehensive mobile application that allows users to browse, search, and purchase various types of organic plants. The app provides detailed plant information, care guides, and a seamless shopping experience with modern UI/UX design.

## ✨ Key Features

### 🔐 Authentication & User Management
- **Phone Number Authentication** using Firebase Auth
- **OTP Verification** for secure login
- **User Profile Management** with personal details
- **Address Management** for delivery

### 🛍️ E-commerce Features
- **Product Catalog** with categorized plant listings
- **Advanced Search & Filtering** by plant categories and attributes
- **Shopping Cart** with quantity management
- **Wishlist** functionality
- **Checkout Process** with address selection
- **Product Details** with comprehensive information

### 🌿 Plant Information
- **Detailed Plant Profiles** with scientific names, care guides, and benefits
- **Plant Categories**: Bonsai, Flowering Plants, Herbs, Indoor Plants, Medicinal Plants, Outdoor Plants, Succulents & Cacti
- **Care Guides** including watering, lighting, temperature, and humidity requirements
- **Plant Attributes** (pet-friendly, air-purifying, low-maintenance, etc.)
- **FAQs** for each plant species

### 🎨 UI/UX Features
- **Modern Material Design 3** implementation
- **Dark & Light Theme** support with dynamic switching
- **Responsive Design** using Flutter ScreenUtil
- **Smooth Animations** and transitions
- **Image Caching** for better performance
- **Custom Components** and reusable widgets

### 🔧 Technical Features
- **State Management** using Provider pattern
- **Firebase Integration** for authentication and hosting
- **HTTP API Integration** for plant data
- **Local Storage** with SharedPreferences
- **Image Caching** with custom cache manager
- **Responsive Layout** support for different screen sizes

## 🏗️ Project Architecture

The project follows a **Feature-Based Architecture** with clean separation of concerns:

```
lib/
├── core/                    # Core functionality
│   ├── services/           # API services, cache management
│   └── theme/              # App themes and styling
├── features/               # Feature modules
│   ├── auth/              # Authentication
│   ├── cart/              # Shopping cart
│   ├── entry/             # App entry point
│   ├── home/              # Home screen
│   ├── onboarding/        # Onboarding flow
│   ├── product/           # Product details
│   ├── profile/           # User profile
│   ├── search/            # Search functionality
│   ├── splash/            # Splash screen
│   ├── store/             # Store features
│   └── wishlist/          # Wishlist management
├── models/                # Data models
├── shared/                # Shared components
│   ├── buttons/           # Custom buttons
│   ├── logic/             # Shared providers
│   └── widgets/           # Reusable widgets
└── main.dart              # App entry point
```

## 🛠️ Technology Stack

### Frontend
- **Flutter** (SDK: ^3.7.2)
- **Dart** programming language
- **Material Design 3** for UI components

### State Management
- **Provider** (^6.1.4) for state management
- **ChangeNotifier** for reactive UI updates

### Backend & Services
- **Firebase Authentication** for user management
- **Firebase Hosting** for static file hosting
- **HTTP** package for API calls
- **SharedPreferences** for local storage

### UI & Animation
- **Lottie** (^3.3.1) for animations
- **Carousel Slider** (5.1.1) for image carousels
- **Smooth Page Indicator** (^1.2.1) for pagination
- **Animated Text Kit** (^4.2.3) for text animations
- **Shimmer** (^3.0.0) for loading effects

### Image & Cache Management
- **Cached Network Image** (^3.3.1) for image caching
- **Flutter Cache Manager** (^3.3.1) for custom caching
- **Custom Cache Manager** implementation

### Utilities
- **Flutter ScreenUtil** (^5.9.3) for responsive design
- **Pinput** (^5.0.1) for OTP input
- **Firebase Remote Config** (^5.4.3) for feature flags

## 📊 Data Structure

### Plant Model (`AllPlantsModel`)
The app uses a comprehensive plant data model with the following structure:

```dart
class AllPlantsModel {
  String? id;
  String? commonName;
  String? scientificName;
  String? category;
  List<String>? tags;
  Attributes? attributes;
  List<Images>? images;
  Prices? prices;
  num? rating;
  bool? inStock;
  PlantQuickGuide? plantQuickGuide;
  Description? description;
  String? howToPlant;
  CareGuide? careGuide;
  String? toxicity;
  String? season;
  bool? flowering;
  String? placement;
  String? soilType;
  String? lifecycleStage;
  String? recommendedPotSize;
  List<String>? benefits;
  List<Faqs>? faqs;
}
```

### Plant Categories
- **Bonsai Plants** - Miniature trees and artistic plants
- **Flowering Plants** - Plants that produce flowers
- **Herbs** - Culinary and medicinal herbs
- **Indoor Plants** - Plants suitable for indoor environments
- **Medicinal Plants** - Plants with health benefits
- **Outdoor Plants** - Plants for gardens and outdoor spaces
- **Succulents & Cacti** - Drought-resistant plants

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.7.2)
- Dart SDK
- Android Studio / VS Code
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd organicplants
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project
   - Enable Authentication with Phone Number provider
   - Configure Firebase Hosting for JSON data
   - Update Firebase configuration in `lib/main.dart`

4. **Run the app**
   ```bash
   flutter run
   ```

### Firebase Configuration

The app requires the following Firebase services:

1. **Authentication**
   - Enable Phone Number authentication
   - Configure OTP settings

2. **Hosting**
   - Host JSON files for plant data
   - Configure CORS for API access

3. **Remote Config** (optional)
   - Configure feature flags and app settings

## 📱 App Screens

### Core Screens
- **Splash Screen** - App initialization and branding
- **Onboarding** - App introduction and feature showcase
- **Login Screen** - Phone number authentication
- **OTP Screen** - Verification code input
- **Home Screen** - Main dashboard with plant categories
- **Product Screen** - Detailed plant information
- **Cart Screen** - Shopping cart management
- **Wishlist Screen** - Saved plants
- **Profile Screen** - User account management
- **Search Screen** - Plant search and filtering

### Additional Screens
- **Address Management** - Delivery address management
- **Checkout Screen** - Order completion
- **Notification Screen** - App notifications
- **About Screen** - App information and policies

## 🎨 Design System

### Color Scheme
- **Primary Green** (#4CAF50) - Main brand color
- **Secondary Orange** (#FF6F00) - Accent color
- **Success Green** (#43A047) - Success states
- **Error Red** (#E53935) - Error states
- **Warning Orange** (#FF9800) - Warning states

### Typography
- **Font Family**: Poppins
- **Responsive Text Scaling** with Flutter ScreenUtil
- **Material Design 3** text styles

### Components
- **Custom Buttons** with different styles and states
- **Plant Cards** with image, price, and rating
- **Search Fields** with advanced filtering
- **Bottom Sheets** for additional options
- **Custom Dialogs** for user interactions

## 🔧 State Management

The app uses **Provider** pattern for state management with the following providers:

- **OnboardingProvider** - Onboarding flow state
- **BottomNavProvider** - Bottom navigation state
- **SearchScreenProvider** - Search functionality state
- **HintTextProvider** - Search hints state
- **WishlistProvider** - Wishlist management
- **CartProvider** - Shopping cart state
- **ProfileProvider** - User profile state
- **ThemeProvider** - Theme switching
- **CarouselProvider** - Image carousel state

## 📊 Data Flow

1. **Plant Data**: Hosted on Firebase Hosting as JSON files
2. **API Calls**: HTTP requests to fetch plant data
3. **Caching**: Images and data cached locally
4. **State Updates**: Provider-based state management
5. **User Data**: Stored locally with SharedPreferences
6. **Authentication**: Firebase Auth for user management

## 🚀 Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Firebase** for backend services
- **Material Design** for design guidelines
- **Plant enthusiasts** for inspiration and feedback

## 📞 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

---

**Made with ❤️ for plant lovers everywhere**
