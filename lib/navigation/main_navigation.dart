import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../screens/home/home_screen.dart';
import '../screens/ingredients/ingredients_screen.dart';
import '../screens/recipes/recipes_screen.dart';
import '../screens/timer/timer_screen.dart';
import '../screens/profile/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    IngredientsScreen(),
    RecipesScreen(),
    TimerScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.kitchen_outlined),
                activeIcon: Icon(Icons.kitchen_rounded),
                label: 'Ingredients',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined),
                activeIcon: Icon(Icons.menu_book_rounded),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer_outlined),
                activeIcon: Icon(Icons.timer_rounded),
                label: 'Timer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
