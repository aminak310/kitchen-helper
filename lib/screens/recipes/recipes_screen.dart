import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import 'recipe_detail_screen.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  int _selectedCategory = 0;
  final TextEditingController _searchController = TextEditingController();
  late List<RecipeModel> _recipes;

  final List<String> _categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];

  // Per-recipe colored backgrounds & emoji (used as food image)
  final List<Color> _cardColors = [
    const Color(0xFFE8F5EE),
    const Color(0xFFFFF3E0),
    const Color(0xFFFFECEC),
    const Color(0xFFFFF8E1),
    const Color(0xFFE3F2FD),
    const Color(0xFFF3E5F5),
  ];

  @override
  void initState() {
    super.initState();
    _recipes = RecipesData.getAllRecipes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<RecipeModel> get _filteredRecipes {
    final query = _searchController.text.toLowerCase();
    return _recipes.where((r) {
      final matchCat = _selectedCategory == 0 ||
          r.category == _categories[_selectedCategory];
      final matchSearch =
          query.isEmpty || r.name.toLowerCase().contains(query);
      return matchCat && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecipes;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F4E6),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: const Icon(Icons.arrow_back_ios_rounded,
              color: Color(0xFF1A2E1F), size: 20),
        ),
        title: const Text(
          'Recipes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A2E1F),
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // ── Search Bar ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Search recipes...',
                  hintStyle: TextStyle(
                    color: Color(0xFFAAC4B4),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                  prefixIcon: Icon(Icons.search_rounded,
                      color: Color(0xFF8FAF9A), size: 20),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // ── Category Filter ──
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final selected = _selectedCategory == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF2E7D52)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF2E7D52)
                                    .withValues(alpha: 0.3),
                                blurRadius: 8,
                              )
                            ]
                          : null,
                    ),
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF8FAF9A),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // ── Recipes List ──
          Expanded(
            child: filtered.isEmpty
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
                        horizontal: 20, vertical: 4),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final recipe = filtered[index];
                      final color =
                          _cardColors[index % _cardColors.length];
                      final globalIndex = _recipes.indexOf(recipe);
                      return _RecipeListCard(
                        recipe: recipe,
                        bgColor: color,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                RecipeDetailScreen(recipe: recipe),
                          ),
                        ),
                        onFavorite: () {
                          setState(() {
                            _recipes[globalIndex].isFavorite =
                                !_recipes[globalIndex].isFavorite;
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Recipe List Card ──
class _RecipeListCard extends StatelessWidget {
  final RecipeModel recipe;
  final Color bgColor;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const _RecipeListCard({
    required this.recipe,
    required this.bgColor,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left: food image / emoji
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
              child: Container(
                width: 95,
                height: 88,
                color: bgColor,
                child: Center(
                  child: Text(
                    recipe.emoji,
                    style: const TextStyle(fontSize: 46),
                  ),
                ),
              ),
            ),

            // Center: info
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A2E1F),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        // Duration
                        const Icon(Icons.timer_outlined,
                            size: 13, color: Color(0xFF8FAF9A)),
                        const SizedBox(width: 3),
                        Text(
                          recipe.duration,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF8FAF9A),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Difficulty badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _difficultyColor(recipe.difficulty)
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            recipe.difficulty,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _difficultyColor(recipe.difficulty),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Right: heart button
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: GestureDetector(
                onTap: onFavorite,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    recipe.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    key: ValueKey(recipe.isFavorite),
                    color: recipe.isFavorite
                        ? Colors.redAccent
                        : const Color(0xFFCCDDD5),
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _difficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return const Color(0xFF2E7D52);
      case 'Medium':
        return const Color(0xFFE8892A);
      case 'Hard':
        return Colors.redAccent;
      default:
        return const Color(0xFF2E7D52);
    }
  }
}
