import 'package:flutter/material.dart';
import 'package:organicplants/screens/search%20screen/search_screen.dart';
import 'package:organicplants/services/app_sizes.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      icon: Icon(Icons.search),
      color: colorScheme.onSurface,
      iconSize: AppSizes.iconMd,
      onPressed: () {
        // Implement search functionality
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
      },
    );
  }
}
