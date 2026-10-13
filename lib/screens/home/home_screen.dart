import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import '../recipes/recipes_screen.dart';
import '../recipes/recipe_detail_screen.dart';
import '../ingredients/ingredients_screen.dart';
import '../shopping/shopping_screen.dart';
import '../timer/timer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<RecipeModel> _allRecipes = [];
  List<RecipeModel> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _allRecipes = RecipesData.getAllRecipes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning,';
    if (hour < 17) return 'Good Afternoon,';
    return 'Good Evening,';
  }

  void _onSearchChanged(String query) {
    setState(() {
      _isSearching = query.trim().isNotEmpty;
      if (_isSearching) {
        _searchResults = _allRecipes
            .where((r) => r.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        _searchResults = [];
      }
    });
  }

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final recipes = _allRecipes.take(4).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E6),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              // ── Top Bar ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _greeting,
                            style: const TextStyle(
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
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No new notifications 🔔'),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Container(
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
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: const InputDecoration(
                      hintText: 'Search recipes, ingredients...',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFAAC4B4),
                        fontFamily: 'Poppins',
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Color(0xFF8FAF9A),
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),

              // ── Search Results OR Main Content ──
              if (_isSearching) ...[
                const SizedBox(height: 8),
                Expanded(
                  child: _searchResults.isEmpty
                      ? const Center(
                          child: Text(
                            'No recipes found 🍽️',
                            style: TextStyle(
                              color: Color(0xFF8FAF9A),
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          itemCount: _searchResults.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final recipe = _searchResults[index];
                            return GestureDetector(
                              onTap: () => _navigateTo(
                                  RecipeDetailScreen(recipe: recipe)),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withValues(alpha: 0.05),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEEF7F1),
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(recipe.emoji,
                                            style: const TextStyle(
                                                fontSize: 28)),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            recipe.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1A2E1F),
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Text(
                                            '${recipe.duration} • ${recipe.category}',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF8FAF9A),
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right_rounded,
                                        color: Color(0xFF8FAF9A), size: 20),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ] else ...[
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),

                        // ── Banner Card ──
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 130,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF1B5E35),
                                  Color(0xFF2E7D52),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF1B5E35)
                                      .withValues(alpha: 0.30),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 55,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 8, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text('Good Food',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Poppins',
                                              height: 1.25,
                                            )),
                                        Text('Brings People',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Poppins',
                                              height: 1.25,
                                            )),
                                        Text('Together 🌿',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Poppins',
                                              height: 1.25,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 45,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(22),
                                      bottomRight: Radius.circular(22),
                                    ),
                                    child: Container(
                                      height: 130,
                                      color: const Color(0xFF245E40),
                                      child: const Center(
                                        child: Text('🍽️',
                                            style:
                                                TextStyle(fontSize: 60)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // ── Quick Actions Grid ──
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _ActionCard(
                                      icon: Icons.kitchen_rounded,
                                      iconColor: const Color(0xFF2E7D52),
                                      iconBg: const Color(0xFFDDF0E6),
                                      title: 'My Ingredients',
                                      subtitle: 'Check what you have',
                                      onTap: () => _navigateTo(
                                          const IngredientsScreen()),
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
                                      onTap: () => _navigateTo(
                                          const RecipesScreen()),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: _ActionCard(
                                      icon: Icons.shopping_cart_rounded,
                                      iconColor: const Color(0xFF2E7D52),
                                      iconBg: const Color(0xFFDDF0E6),
                                      title: 'Shopping List',
                                      subtitle: 'What you need',
                                      onTap: () => _navigateTo(
                                          const ShoppingScreen()),
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
                                      onTap: () => _navigateTo(
                                          const TimerScreen()),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: _ActionCard(
                                      icon: Icons.favorite_rounded,
                                      iconColor: const Color(0xFF2E7D52),
                                      iconBg: const Color(0xFFDDF0E6),
                                      title: 'Favorite Recipes',
                                      subtitle: 'Your saved meals',
                                      onTap: () => _navigateTo(
                                          const RecipesScreen()),
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
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Meal Planner coming soon! 📅'),
                                            duration:
                                                Duration(seconds: 1),
                                            behavior:
                                                SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                onTap: () =>
                                    _navigateTo(const RecipesScreen()),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: recipes.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final recipe = recipes[index];
                              return GestureDetector(
                                onTap: () => _navigateTo(
                                    RecipeDetailScreen(recipe: recipe)),
                                child: _RecipeCard(recipe: recipe),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
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
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(18)),
            child: Container(
              height: 90,
              color: const Color(0xFFEEF7F1),
              child: Center(
                child: Text(recipe.emoji,
                    style: const TextStyle(fontSize: 46)),
              ),
            ),
          ),
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
