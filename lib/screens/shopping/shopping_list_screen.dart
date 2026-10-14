import 'package:flutter/material.dart';
import 'shopping_screen.dart';

export 'shopping_screen.dart';

/// Alias and wrapper widget for ShoppingScreen to support shopping list screen navigation.
class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShoppingScreen();
  }
}
