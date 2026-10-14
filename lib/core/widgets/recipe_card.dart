import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import '../constants/app_colors.dart';

enum RecipeCardLayout {
  list,
  grid,
}

/// Reusable recipe card widget supporting both list and grid presentations.
class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;
  final RecipeCardLayout layout;
  final Color? emojiBackgroundColor;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    this.onFavoriteToggle,
    this.layout = RecipeCardLayout.list,
    this.emojiBackgroundColor,
  });

  Color _resolveBgColor() {
    if (emojiBackgroundColor != null) return emojiBackgroundColor!;
    final colors = [
      const Color(0xFFE8F5EE),
      const Color(0xFFFFF3E0),
      const Color(0xFFFFECEC),
      const Color(0xFFFFF8E1),
      const Color(0xFFE3F2FD),
      const Color(0xFFF3E5F5),
    ];
    return colors[recipe.name.length % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    if (layout == RecipeCardLayout.grid) {
      return _buildGridCard(context);
    }
    return _buildListCard(context);
  }

  // ── Horizontal / List Card Layout ──
  Widget _buildListCard(BuildContext context) {
    final bgColor = _resolveBgColor();

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
            // Emoji / Image container
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
                    style: const TextStyle(fontSize: 44),
                  ),
                ),
              ),
            ),

            // Recipe info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                        fontFamily: 'Poppins',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: AppColors.textMedium,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          recipe.duration,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMedium,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.textLight,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          recipe.difficulty,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: recipe.difficulty.toLowerCase() == 'easy'
                                ? AppColors.primary
                                : (recipe.difficulty.toLowerCase() == 'medium'
                                    ? AppColors.accent
                                    : AppColors.error),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        recipe.category,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Favorite Button
            if (onFavoriteToggle != null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: recipe.isFavorite
                          ? const Color(0xFFFFECEC)
                          : const Color(0xFFF5F5F5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: recipe.isFavorite
                          ? const Color(0xFFE53935)
                          : const Color(0xFF8FAF9A),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ── Grid / Vertical Card Layout ──
  Widget _buildGridCard(BuildContext context) {
    final bgColor = _resolveBgColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top emoji hero with favorite icon
            Stack(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      recipe.emoji,
                      style: const TextStyle(fontSize: 54),
                    ),
                  ),
                ),
                if (onFavoriteToggle != null)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: recipe.isFavorite
                              ? const Color(0xFFE53935)
                              : const Color(0xFF8FAF9A),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Bottom detail section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 13,
                        color: AppColors.textMedium,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        recipe.duration,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMedium,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Spacer(),
                      Text(
                        recipe.difficulty,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: recipe.difficulty.toLowerCase() == 'easy'
                              ? AppColors.primary
                              : AppColors.accent,
                        ),
                      ),
                    ],
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
