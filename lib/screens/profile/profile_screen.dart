import 'package:flutter/material.dart';
import '../recipes/recipes_screen.dart';
import '../ingredients/ingredients_screen.dart';
import '../shopping/shopping_screen.dart';
import '../timer/timer_screen.dart';
import '../../models/recipe_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFFAF8F3);
    const primaryGreen = Color(0xFF1B5E35);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: primaryGreen,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: primaryGreen, size: 24),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings opened'),
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 12),

            // ── User Info Row ──
            Row(
              children: [
                // Avatar with cute custom illustration
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA1C69A),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen.withValues(alpha: 0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background base
                        Container(color: const Color(0xFFA1C69A)),
                        // Shoulders / Shirt
                        Positioned(
                          bottom: -2,
                          child: Container(
                            width: 52,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3B6846),
                              borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                            ),
                          ),
                        ),
                        // Hair back
                        Positioned(
                          top: 14,
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Color(0xFF4A3425),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // Face
                        Positioned(
                          top: 20,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF7C8A0),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // Hair bangs / front
                        Positioned(
                          top: 16,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 15,
                                height: 14,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4A3425),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    topLeft: Radius.circular(6),
                                  ),
                                ),
                              ),
                              Container(
                                width: 15,
                                height: 14,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4A3425),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Smile / face details
                        Positioned(
                          top: 34,
                          child: Container(
                            width: 8,
                            height: 4,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: const Color(0xFF4A3425).withValues(alpha: 0.8),
                                  width: 1.5,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Name & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Amina Kiran',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primaryGreen,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: const [
                          Text(
                            'Food Lover',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4F6E56),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              '•',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF4F6E56),
                              ),
                            ),
                          ),
                          Text(
                            'Home Cook 🌿',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4F6E56),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Stats Row (3 Cards) ──
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    '${RecipesData.getAllRecipes().length}',
                    'Recipes Saved',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    '${RecipesData.getAllRecipes().where((r) => r.isFavorite).length}',
                    'Favorites',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    '${RecipesData.getAllRecipes().map((r) => r.category).toSet().length}',
                    'Categories',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // ── Menu Section (Single White Container) ──
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.calendar_today_outlined,
                    title: 'My Recipes',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RecipesScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.eco_outlined,
                    title: 'My Ingredients',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const IngredientsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.shopping_cart_outlined,
                    title: 'Shopping List',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ShoppingScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.timer_outlined,
                    title: 'Cooking Timer',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TimerScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Settings menu tapped'),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.help_outline_rounded,
                    title: 'Help & Support',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Kitchen Helper v1.0.0 • Help & Support'),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Decorative Bottom Banner ("Good food = Good mood 🧡") ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFF1F6EE),
                    const Color(0xFFFAF6E9).withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE4EDE0),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  // Decorative plant leaves on left
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Transform.rotate(
                      angle: -0.2,
                      child: const Text('🌿', style: TextStyle(fontSize: 32)),
                    ),
                  ),

                  // Decorative plant leaves & sun on right
                  Positioned(
                    right: 4,
                    bottom: 0,
                    child: Transform.rotate(
                      angle: 0.15,
                      child: const Text('🌱', style: TextStyle(fontSize: 34)),
                    ),
                  ),

                  // Centered quote
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Good food',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2A6A3F),
                            fontFamily: 'Poppins',
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '= Good mood 🧡',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2A6A3F),
                            fontFamily: 'Poppins',
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String count, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B5E35),
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF7E9383),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF2E7D52), size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A2E1F),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF6B9B7E),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: Color(0xFFF1EFEA),
    );
  }
}
