import '../models/recipe_model.dart';
export '../models/recipe_model.dart';

/// Comprehensive recipe dataset and repository for Kitchen Helper.
class SampleRecipes {
  static const List<String> categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Dessert',
    'Snacks',
  ];

  static List<RecipeModel> getAllRecipes() {
    return [
      ...RecipesData.getAllRecipes(),
      RecipeModel(
        name: 'Creamy Alfredo Pasta',
        duration: '20 mins',
        difficulty: 'Easy',
        emoji: '🍝',
        image: '🍝',
        isFavorite: false,
        category: 'Dinner',
        serves: 2,
        ingredients: [
          'Fettuccine or Penne — 250 g',
          'Heavy Cream — 1 cup',
          'Butter — 2 tbsp',
          'Garlic — 3 cloves minced',
          'Parmesan Cheese — ½ cup',
          'Black Pepper & Salt to taste',
        ],
        steps: [
          'Boil pasta in salted water until al dente.',
          'Melt butter in skillet, sauté minced garlic.',
          'Pour in cream, simmer gently on medium heat.',
          'Stir in parmesan cheese until smooth.',
          'Toss pasta in sauce, garnish with pepper and serve.',
        ],
      ),
      RecipeModel(
        name: 'Mediterranean Greek Salad',
        duration: '15 mins',
        difficulty: 'Easy',
        emoji: '🥗',
        image: '🥗',
        isFavorite: false,
        category: 'Lunch',
        serves: 2,
        ingredients: [
          'Cucumber — 1 large diced',
          'Tomatoes — 2 ripe diced',
          'Red Onion — ½ sliced thin',
          'Feta Cheese — 100 g cubed',
          'Kalamata Olives — 8 pcs',
          'Extra Virgin Olive Oil — 2 tbsp',
          'Dried Oregano & Lemon Juice',
        ],
        steps: [
          'Wash and chop cucumbers, tomatoes, and red onion.',
          'Combine vegetables and olives in a salad bowl.',
          'Top with feta cheese cubes.',
          'Drizzle olive oil and fresh lemon juice.',
          'Season with dried oregano and serve chilled.',
        ],
      ),
      RecipeModel(
        name: 'Classic Mango Lassi',
        duration: '5 mins',
        difficulty: 'Easy',
        emoji: '🥭',
        image: '🥭',
        isFavorite: true,
        category: 'Dessert',
        serves: 2,
        ingredients: [
          'Ripe Mango Pulp — 1 cup',
          'Plain Yogurt — 1 cup',
          'Milk — ½ cup',
          'Sugar or Honey — 2 tbsp',
          'Cardamom powder — pinch',
          'Ice cubes — 4 pcs',
        ],
        steps: [
          'Add mango pulp, cold yogurt, and milk to blender.',
          'Add sugar and cardamom powder.',
          'Blend on high until smooth and frothy.',
          'Pour into chilled glasses over ice.',
          'Garnish with chopped pistachios and enjoy!',
        ],
      ),
      RecipeModel(
        name: 'Crispy Veg Pakoras',
        duration: '20 mins',
        difficulty: 'Medium',
        emoji: '🥟',
        image: '🥟',
        isFavorite: false,
        category: 'Snacks',
        serves: 3,
        ingredients: [
          'Gram Flour (Besan) — 1 cup',
          'Onion sliced — 2 pcs',
          'Potato sliced thin — 1 pcs',
          'Spinach chopped — ½ cup',
          'Green Chilies — 2 chopped',
          'Cumin & Coriander seeds — 1 tsp',
          'Oil for deep frying',
        ],
        steps: [
          'Mix sliced vegetables in a mixing bowl.',
          'Add gram flour, spices, salt, and chili.',
          'Sprinkle small amount of water to form thick batter.',
          'Drop spoonfuls into hot oil.',
          'Fry until golden brown and crispy, serve with chutney.',
        ],
      ),
    ];
  }

  /// Recipes marked as favorites.
  static List<RecipeModel> getFavorites() {
    return getAllRecipes().where((r) => r.isFavorite).toList();
  }

  /// Popular recipes (quick and easy meals).
  static List<RecipeModel> getPopularRecipes() {
    return getAllRecipes().take(4).toList();
  }

  /// Filter recipes by category.
  static List<RecipeModel> getByCategory(String category) {
    if (category.toLowerCase() == 'all') {
      return getAllRecipes();
    }
    return getAllRecipes()
        .where((r) => r.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  /// Live search helper.
  static List<RecipeModel> search(String query) {
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) return getAllRecipes();
    return getAllRecipes().where((r) {
      final matchName = r.name.toLowerCase().contains(cleanQuery);
      final matchCategory = r.category.toLowerCase().contains(cleanQuery);
      final matchIngredients =
          r.ingredients.any((ing) => ing.toLowerCase().contains(cleanQuery));
      return matchName || matchCategory || matchIngredients;
    }).toList();
  }
}
