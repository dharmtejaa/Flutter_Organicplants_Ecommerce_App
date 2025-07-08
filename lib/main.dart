import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/theme/app_theme.dart';
import 'package:organicplants/features/cart/logic/cart_provider.dart';
import 'package:organicplants/features/entry/logic/bottom_nav_provider.dart';
import 'package:organicplants/features/home/logic/onboarding_provider.dart';
import 'package:organicplants/features/product/logic/carousel_provider.dart';
import 'package:organicplants/features/profile/logic/profile_provider.dart';
import 'package:organicplants/features/search/logic/hint_text_provider.dart';
import 'package:organicplants/features/search/logic/search_screen_provider.dart';
import 'package:organicplants/features/splash/presentation/screens/splashscreen.dart';
import 'package:organicplants/features/wishlist/logic/wishlist_provider.dart';
import 'package:organicplants/shared/logic/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBfbYeG53nOm2E0amp-XNe2SSuCdkiI8v8",
      appId: "1:662081729826:android:6db49ff6e6f8abaf37e17b",
      messagingSenderId: "662081729826",
      projectId: "organicplants143",
      storageBucket: "organicplants143.firebasestorage.app",
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => SearchScreenProvider()),
        ChangeNotifierProvider(create: (_) => HintTextProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ), // Your ThemeProvider
        ChangeNotifierProvider(create: (_) => CarouselProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Design size for scaling
      minTextAdapt: true, // Enable text scaling
      splitScreenMode: true, // Enable split screen mode for better performance
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeProvider>(
          context,
        ); // Get the theme provider
        return MaterialApp(
          builder: (context, widget) {
            // 👇 Overrides global system font scaling
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(1.0)),
              child: widget!,
            );
          },
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme, // Your light theme
          darkTheme: AppTheme.darkTheme, // Your dark theme
          themeMode:
              themeProvider
                  .themeMode, // This will dynamically change based on provider
          home: const Splashscreen(),
        );
      },
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MaterialApp(
//           builder: (context, child) {
//             return MediaQuery(
//               data: MediaQuery.of(
//                 context,
//               ).copyWith(textScaler: TextScaler.linear(1.0)),
//               child: child!,
//             );
//           },
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             // scaffoldBackgroundColor: const Color.fromARGB(
//             //   255,
//             //   243,
//             //   249,
//             //   247,
//             // ), //
//             scaffoldBackgroundColor: Colors.grey.shade300,
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             appBarTheme: AppBarTheme(
//               backgroundColor: Color.fromARGB(255, 243, 249, 247),
//               foregroundColor: Colors.black,
//               scrolledUnderElevation: 0,

//               elevation: 0,
//             ),
//             colorScheme: ColorScheme.light(
//               // ignore: deprecated_member_use
//               background: Color.fromARGB(255, 243, 249, 247),
//             ),
//             // colorScheme: ColorScheme.fromSeed(
//             //   seedColor: Colors.white,
//             //   brightness: Brightness.light,
//             // ).copyWith(
//             //   primary: Colors.white,
//             //   secondary: Colors.white,
//             //   surface: Colors.white,
//             //   onPrimary: Colors.white, // text/icon color on green
//             //   onSecondary: Colors.black, // text/icon color on white
//             // ),
//           ),

//           home: Splashscreen(),
//         );
//       },
//     );
//   }
// }
