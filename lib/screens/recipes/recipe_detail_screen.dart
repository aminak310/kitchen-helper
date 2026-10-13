import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import '../timer/timer_screen.dart';
import '../ingredients/ingredients_screen.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeModel recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.recipe.isFavorite;
  }

  // Per-recipe card background colors
  Color get _bgColor {
    final colors = [
      const Color(0xFFE8F5EE),
      const Color(0xFFFFF3E0),
      const Color(0xFFFFECEC),
      const Color(0xFFFFF8E1),
      const Color(0xFFE3F2FD),
      const Color(0xFFF3E5F5),
    ];
    return colors[widget.recipe.name.length % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4E6),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Sliver App Bar with food image ──
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: const Color(0xFFF2F4E6),
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back_ios_rounded,
                    color: Color(0xFF1A2E1F), size: 18),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => setState(() => _isFavorite = !_isFavorite),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      _isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      key: ValueKey(_isFavorite),
                      color: _isFavorite
                          ? Colors.redAccent
                          : const Color(0xFFCCDDD5),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Food emoji area (safe fallback — no asset crash risk)
                  Container(
                    color: _bgColor,
                    child: Center(
                      child: Text(
                        recipe.emoji,
                        style: const TextStyle(fontSize: 110),
                      ),
                    ),
                  ),
                  // Gradient overlay at bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            const Color(0xFFF2F4E6).withValues(alpha: 0.9),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  // Image counter badge
                  Positioned(
                    bottom: 14,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        '1/4',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Content ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A2E1F),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Info chips row
                  Row(
                    children: [
                      _InfoChip(
                        icon: Icons.timer_outlined,
                        label: recipe.duration,
                      ),
                      const SizedBox(width: 10),
                      _InfoChip(
                        icon: Icons.bar_chart_rounded,
                        label: recipe.difficulty,
                      ),
                      const SizedBox(width: 10),
                      _InfoChip(
                        icon: Icons.people_outline_rounded,
                        label: 'Serves ${recipe.serves}',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Ingredients header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A2E1F),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const IngredientsScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            color: Color(0xFF2E7D52),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Ingredients list
                  ...recipe.ingredients.map(
                    (ing) => _IngredientRow(text: ing),
                  ),

                  const SizedBox(height: 22),

                  // Cooking Steps header
                  const Text(
                    'Cooking Steps',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A2E1F),
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Steps list
                  ...recipe.steps.asMap().entries.map(
                        (e) => _StepTile(index: e.key + 1, text: e.value),
                      ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Start Cooking Button ──
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        color: const Color(0xFFF2F4E6),
        child: SizedBox(
          height: 54,
          child: ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TimerScreen()),
            ),
            icon: const Icon(Icons.restaurant_rounded,
                size: 20, color: Colors.white),
            label: const Text(
              'Start Cooking',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Info Chip ──
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5EE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: const Color(0xFF2E7D52)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF2E7D52),
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

// ── Ingredient Row ──
class _IngredientRow extends StatelessWidget {
  final String text;
  const _IngredientRow({required this.text});

  @override
  Widget build(BuildContext context) {
    final parts = text.split('—');
    final name = parts[0].trim();
    final qty = parts.length > 1 ? parts[1].trim() : '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8892A),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A2E1F),
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          Text(
            qty,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF8FAF9A),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Step Tile ──
class _StepTile extends StatelessWidget {
  final int index;
  final String text;
  const _StepTile({required this.index, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFF2E7D52),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF4A6355),
                  fontFamily: 'Poppins',
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
