import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import 'recipe_detail_screen.dart';

export 'recipe_detail_screen.dart';

/// Alias and wrapper widget for RecipeDetailScreen to support both naming styles.
class RecipeDetailsScreen extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailsScreen({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return RecipeDetailScreen(recipe: recipe);
  }
}
