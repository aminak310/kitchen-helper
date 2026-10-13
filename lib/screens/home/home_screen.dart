import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipes = RecipesData.getAllRecipes().take(4).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E6),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Top Bar: Good Morning + Bell ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Good Morning,',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF5A7A6A),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Row(
                            children: const [
                              Text(
                                'Amina',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A2E1F),
                                  fontFamily: 'Poppins',
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text('🌿', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Notification bell
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.07),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFF4A6355),
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ── Search Bar ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: const [
                      SizedBox(width: 18),
                      Icon(Icons.search_rounded,
                          color: Color(0xFF8FAF9A), size: 20),
                      SizedBox(width: 10),
                      Text(
                        'Search recipes, ingredients...',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFAAC4B4),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ── Banner Card with REAL food image ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1B5E35), Color(0xFF2E7D52)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1B5E35).withValues(alpha: 0.30),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Left: text
                      Expanded(
                        flex: 55,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Good Food',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Poppins',
                                  height: 1.25,
                                ),
                              ),
                              Text(
                                'Brings People',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Poppins',
                                  height: 1.25,
                                ),
                              ),
                              Text(
                                'Together 🌿',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Poppins',
                                  height: 1.25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Right: real food image
                      Expanded(
                        flex: 45,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(22),
                            bottomRight: Radius.circular(22),
                          ),
                          child: Image.asset(
                            'assets/images/banner_food.png',
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // ── Quick Actions Grid (3 rows × 2 cols) ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Row 1
                    Row(
                      children: [
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.kitchen_rounded,
                            iconColor: const Color(0xFF2E7D52),
                            iconBg: const Color(0xFFDDF0E6),
                            title: 'My Ingredients',
                            subtitle: 'Check what you have',
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.search_rounded,
                            iconColor: const Color(0xFFE8892A),
                            iconBg: const Color(0xFFFFEDD5),
                            title: 'Find Recipes',
                            subtitle: 'Based on ingredients',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Row 2
                    Row(
                      children: [
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.shopping_cart_rounded,
                            iconColor: const Color(0xFF2E7D52),
                            iconBg: const Color(0xFFDDF0E6),
                            title: 'Shopping List',
                            subtitle: 'What you need',
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.timer_rounded,
                            iconColor: const Color(0xFFE8892A),
                            iconBg: const Color(0xFFFFEDD5),
                            title: 'Cooking Timer',
                            subtitle: 'Never overcook',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Row 3
                    Row(
                      children: [
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.favorite_rounded,
                            iconColor: const Color(0xFF2E7D52),
                            iconBg: const Color(0xFFDDF0E6),
                            title: 'Favorite Recipes',
                            subtitle: 'Your saved meals',
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.calendar_month_rounded,
                            iconColor: const Color(0xFFE8892A),
                            iconBg: const Color(0xFFFFEDD5),
                            title: 'Meal Planner',
                            subtitle: 'Plan your week',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Popular Recipes header ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Recipes',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A2E1F),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF2E7D52),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ── Popular Recipes horizontal scroll ──
              SizedBox(
                height: 155,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: recipes.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return _RecipeCard(recipe: recipe);
                  },
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Action Card Widget ──
class _ActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;

  const _ActionCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Colored icon circle
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 10),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A2E1F),
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: Color(0xFF8FAF9A),
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Recipe Card Widget ──
class _RecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const _RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food emoji area
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(18)),
            child: Container(
              height: 90,
              color: const Color(0xFFEEF7F1),
              child: Center(
                child:
                    Text(recipe.emoji, style: const TextStyle(fontSize: 46)),
              ),
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A2E1F),
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        size: 10, color: Color(0xFF8FAF9A)),
                    const SizedBox(width: 3),
                    Text(
                      recipe.duration,
                      style: const TextStyle(
                        fontSize: 9.5,
                        color: Color(0xFF8FAF9A),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF7F1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        recipe.difficulty,
                        style: const TextStyle(
                          fontSize: 8.5,
                          color: Color(0xFF2E7D52),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
