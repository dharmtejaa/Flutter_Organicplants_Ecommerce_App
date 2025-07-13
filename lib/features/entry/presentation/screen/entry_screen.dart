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

  static final List<Widget> _screens = [
    const HomeScreen(),
    const StoreScreen(),
    const SearchScreen(),
    const ProfileScreen(),
    const CartScreen(),
  ];

  @override
  State<EntryScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    //final textTheme = Theme.of(context).textTheme;
    final currentIndex = context.select<BottomNavProvider, int>(
      (p) => p.currentIndex,
    );

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: EntryScreen._screens),

      /// Only BottomNavigationBar listens for changes
      bottomNavigationBar: Consumer<BottomNavProvider>(
        builder:
            (context, provider, _) => Container(
              //margin: EdgeInsets.only(left: 0, right: 12, bottom: 0),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                //borderRadius: BorderRadius.circular(24),
                // boxShadow: [
                //   BoxShadow(
                //     color: colorScheme.shadow.withOpacity(0.10),
                //     blurRadius: 18,
                //     offset: Offset(0, 4),
                //   ),
                // ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusXxl),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  enableFeedback: true,
                  currentIndex: provider.currentIndex,
                  iconSize: AppSizes.iconSm,
                  selectedFontSize: AppSizes.fontSm,
                  unselectedFontSize: AppSizes.fontSm,
                  selectedItemColor: colorScheme.primary,
                  unselectedItemColor: colorScheme.onSurface,
                  backgroundColor: Colors.transparent,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  onTap: provider.updateIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: _NavBarIcon(
                        icon: Icons.home,
                        selected: provider.currentIndex == 0,
                        colorScheme: colorScheme,
                      ),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: _NavBarIcon(
                        icon: Icons.storefront,
                        selected: provider.currentIndex == 1,
                        colorScheme: colorScheme,
                      ),
                      label: "Store",
                    ),
                    BottomNavigationBarItem(
                      icon: _NavBarIcon(
                        icon: Icons.search_outlined,
                        selected: provider.currentIndex == 2,
                        colorScheme: colorScheme,
                      ),
                      label: "Search",
                    ),
                    BottomNavigationBarItem(
                      icon: _NavBarIcon(
                        icon: Icons.account_circle_outlined,
                        selected: provider.currentIndex == 3,
                        colorScheme: colorScheme,
                      ),
                      label: "Profile",
                    ),
                    BottomNavigationBarItem(
                      icon: _NavBarIcon(
                        iconWidget: CartIconWithBadge(
                          iconColor: colorScheme.onSurface,
                        ),
                        selected: provider.currentIndex == 4,
                        colorScheme: colorScheme,
                        activeIconWidget: CartIconWithBadge(
                          iconColor: colorScheme.primary,
                        ),
                      ),
                      label: "Cart",
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final Widget? activeIconWidget;
  final bool selected;
  final ColorScheme colorScheme;
  const _NavBarIcon({
    this.icon,
    this.iconWidget,
    this.activeIconWidget,
    required this.selected,
    required this.colorScheme,
  });
  @override
  Widget build(BuildContext context) {
    final Widget child =
        iconWidget != null
            ? (selected && activeIconWidget != null
                ? activeIconWidget!
                : iconWidget!)
            : Icon(
              icon,
              size: selected ? 30 : 24,
              color: selected ? colorScheme.primary : colorScheme.onSurface,
            );
    return AnimatedContainer(
      duration: Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.symmetric(horizontal: selected ? 10 : 0, vertical: 2),
      margin: EdgeInsets.only(bottom: 2),
      decoration:
          selected
              ? BoxDecoration(
                color: colorScheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              )
              : null,
      child: child,
    );
  }
}
