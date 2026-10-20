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
            onPressed: () => _showSettings(context),
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
                    onTap: () => _showSettings(context),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () => _showPrivacyPolicy(context),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.help_outline_rounded,
                    title: 'Help & Support',
                    onTap: () => _showHelpSupport(context),
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

  void _showPrivacyPolicy(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Color(0xFFFAF8F3),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    const Icon(Icons.privacy_tip_rounded, color: Color(0xFF1B5E35), size: 26),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1B5E35),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Color(0xFF1B5E35)),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFFE4EDE0)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: const [
                    Text(
                      'Last updated: October 2026',
                      style: TextStyle(fontSize: 12, color: Color(0xFF7E9383), fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Introduction',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1A2E1F)),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Kitchen Helper ("we", "our", or "the app") is committed to protecting your privacy. This Privacy Policy explains our practices regarding user information for Kitchen Helper.',
                      style: TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF3B5242)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '1. Information We Do NOT Collect',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1A2E1F)),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '• We do not collect personally identifiable information (such as your real name, address, email, or phone number).\n'
                      '• We do not track or collect your location data.\n'
                      '• We do not access your contacts, camera, photos, or microphone.\n'
                      '• We do not use third-party tracking cookies or advertising identifiers.',
                      style: TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF3B5242)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '2. Local Device Storage',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1A2E1F)),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'All your app preferences, saved recipes, custom ingredients, and shopping lists are stored solely on your device. This data never leaves your device and is not transmitted to external servers.',
                      style: TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF3B5242)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '3. Third-Party Services & Ads',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1A2E1F)),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Kitchen Helper does not include third-party advertising SDKs or data brokers. No data is shared with or sold to any third party.',
                      style: TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF3B5242)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '4. Children\'s Privacy (COPPA Compliance)',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1A2E1F)),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Our app is safe for general audiences. Because we do not collect any personal data whatsoever, we comply with COPPA and global child privacy standards.',
                      style: TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF3B5242)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '5. Data Deletion',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1A2E1F)),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'You retain complete control of your data. Uninstalling Kitchen Helper or clearing app cache/storage in your device settings will permanently remove all local data.',
                      style: TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF3B5242)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '6. Contact Information',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1A2E1F)),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'If you have any questions or suggestions regarding this Privacy Policy, please contact the developer at:\nsupport@kitchenhelper.app',
                      style: TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF3B5242)),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFFAF8F3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Settings & Preferences',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1B5E35),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Color(0xFF1B5E35)),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    tileColor: Colors.white,
                    leading: const Icon(Icons.straighten_rounded, color: Color(0xFF2E7D52)),
                    title: const Text('Measurement Units', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Metric (grams, liters, ml)', style: TextStyle(fontSize: 12, color: Color(0xFF7E9383))),
                    trailing: const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D52), size: 20),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    tileColor: Colors.white,
                    leading: const Icon(Icons.notifications_active_outlined, color: Color(0xFF2E7D52)),
                    title: const Text('Timer Sound Alert', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Chime & in-app alerts active', style: TextStyle(fontSize: 12, color: Color(0xFF7E9383))),
                    trailing: const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D52), size: 20),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    tileColor: Colors.white,
                    leading: const Icon(Icons.info_outline_rounded, color: Color(0xFF2E7D52)),
                    title: const Text('App Version', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    trailing: const Text('v1.0.0 (Build 1)', style: TextStyle(color: Color(0xFF7E9383), fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showHelpSupport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Color(0xFFFAF8F3),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    const Icon(Icons.help_center_rounded, color: Color(0xFF1B5E35), size: 26),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Help & Support',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1B5E35),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Color(0xFF1B5E35)),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFFE4EDE0)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4EDE0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('🍳 Cooking Timer', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF1B5E35))),
                          SizedBox(height: 4),
                          Text('Use quick presets (5m, 10m, 15m, 30m) or customize the time. When the timer hits 0:00, an alert dialog will notify you.', style: TextStyle(fontSize: 13, color: Color(0xFF3B5242))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4EDE0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('🛒 Shopping List', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF1B5E35))),
                          SizedBox(height: 4),
                          Text('Tap items to mark them as purchased, or use the tabs to separate needed ingredients from already purchased items.', style: TextStyle(fontSize: 13, color: Color(0xFF3B5242))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4EDE0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('✉️ Developer Contact', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF1B5E35))),
                          SizedBox(height: 4),
                          Text('For inquiries, feedback, or assistance, reach us at support@kitchenhelper.app. We typically respond within 24 hours.', style: TextStyle(fontSize: 13, color: Color(0xFF3B5242))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

