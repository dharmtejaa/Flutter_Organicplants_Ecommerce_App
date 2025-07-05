import 'package:flutter/material.dart';
import 'package:organicplants/core/services/app_sizes.dart';
import 'package:organicplants/features/cart/presentation/screens/cart_screen.dart';
import 'package:organicplants/features/entry/logic/bottom_nav_provider.dart';
import 'package:organicplants/features/home/presentation/screens/home_screen.dart';
import 'package:organicplants/features/profile/presentation/screens/profile_screen.dart';
import 'package:organicplants/features/search/presentation/screens/search_screen.dart';
import 'package:organicplants/features/store/presentation/screen/store_screen.dart';
import 'package:organicplants/shared/buttons/cart_icon_with_batdge.dart';
import 'package:provider/provider.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    StoreTab(),
    SearchScreen(),
    ProfileTab(),
    CartScreen(),
  ];

  @override
  State<EntryScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentIndex = context.select<BottomNavProvider, int>(
      (p) => p.currentIndex,
    );

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: EntryScreen._screens),

      /// Only BottomNavigationBar listens for changes
      bottomNavigationBar: Consumer<BottomNavProvider>(
        builder:
            (context, provider, _) => BottomNavigationBar(
              type: BottomNavigationBarType.shifting,

              //showUnselectedLabels: true,

              //showSelectedLabels: true,
              elevation: 0,
              enableFeedback: true,
              iconSize: AppSizes.iconMd,
              selectedFontSize: AppSizes.fontMd,
              unselectedFontSize: AppSizes.fontSm,
              currentIndex: provider.currentIndex,
              onTap: provider.updateIndex,
              selectedItemColor: colorScheme.primary,
              unselectedItemColor: Colors.grey,
              backgroundColor: colorScheme.surface,

              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.storefront),
                  label: "Store",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  label: "Search",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  label: "Profile",
                ),
                BottomNavigationBarItem(
                  icon: const CartIconWithBadge(iconColor: Colors.grey),
                  activeIcon: CartIconWithBadge(iconColor: colorScheme.primary),
                  label: "Cart",
                ),
              ],
            ),
      ),
    );
  }
}
