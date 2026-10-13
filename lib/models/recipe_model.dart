class RecipeModel {
  final String name;
  final String duration;
  final String difficulty;
  final String emoji;
  final String image;
  bool isFavorite;
  final String category;
  final List<String> ingredients;
  final List<String> steps;
  final int serves;

  RecipeModel({
    required this.name,
    required this.duration,
    required this.difficulty,
    required this.emoji,
    required this.image,
    this.isFavorite = false,
    required this.category,
    required this.ingredients,
    required this.steps,
    this.serves = 2,
  });
}

class RecipesData {
  static List<RecipeModel> getAllRecipes() {
    return [
      RecipeModel(
        name: 'Vegetable Fried Rice',
        duration: '25 mins',
        difficulty: 'Easy',
        emoji: '🍛',
        image: '🍛',
        isFavorite: true,
        category: 'Lunch',
        serves: 2,
        ingredients: [
          'Rice — 1 cup',
          'Carrot — 1 pcs',
          'Capsicum — 1 pcs',
          'Onion — 1 pcs',
          'Soy sauce — 2 tbsp',
          'Oil — 2 tbsp',
        ],
        steps: [
          'Cook rice and keep aside.',
          'Heat oil in a pan, add onion and sauté.',
          'Add vegetables and cook for 5 minutes.',
          'Add rice, soy sauce and mix well.',
          'Serve hot and enjoy!',
        ],
      ),
      RecipeModel(
        name: 'Chicken Karahi',
        duration: '40 mins',
        difficulty: 'Medium',
        emoji: '🍲',
        image: '🍲',
        isFavorite: false,
        category: 'Dinner',
        serves: 4,
        ingredients: [
          'Chicken — 500g',
          'Tomato — 3 pcs',
          'Onion — 2 pcs',
          'Garlic — 4 cloves',
          'Spices — as needed',
          'Oil — 3 tbsp',
        ],
        steps: [
          'Heat oil in karahi, add garlic.',
          'Add chicken and cook until golden.',
          'Add tomatoes and spices.',
          'Cook on medium heat 25 mins.',
          'Garnish with ginger and serve.',
        ],
      ),
      RecipeModel(
        name: 'Spaghetti Pasta',
        duration: '30 mins',
        difficulty: 'Easy',
        emoji: '🍝',
        image: '🍝',
        isFavorite: true,
        category: 'Lunch',
        serves: 2,
        ingredients: [
          'Pasta — 200g',
          'Tomato sauce — 1 cup',
          'Garlic — 3 cloves',
          'Olive oil — 2 tbsp',
          'Basil — handful',
          'Parmesan — to taste',
        ],
        steps: [
          'Boil pasta until al dente.',
          'Sauté garlic in olive oil.',
          'Add tomato sauce and simmer.',
          'Mix pasta into sauce.',
          'Top with basil and parmesan.',
        ],
      ),
      RecipeModel(
        name: 'Masoor Dal',
        duration: '35 mins',
        difficulty: 'Easy',
        emoji: '🍜',
        image: '🍜',
        isFavorite: false,
        category: 'Dinner',
        serves: 4,
        ingredients: [
          'Masoor dal — 1 cup',
          'Onion — 1 pcs',
          'Tomato — 2 pcs',
          'Garlic — 2 cloves',
          'Turmeric — 1 tsp',
          'Oil — 2 tbsp',
        ],
        steps: [
          'Wash and soak dal for 20 mins.',
          'Boil dal with turmeric.',
          'Prepare tarka with onion & garlic.',
          'Add tomatoes to tarka.',
          'Mix tarka with dal and serve.',
        ],
      ),
      RecipeModel(
        name: 'Fruit Smoothie Bowl',
        duration: '10 mins',
        difficulty: 'Easy',
        emoji: '🥣',
        image: '🥣',
        isFavorite: true,
        category: 'Breakfast',
        serves: 1,
        ingredients: [
          'Banana — 2 pcs',
          'Mixed berries — 1 cup',
          'Yogurt — ½ cup',
          'Honey — 1 tbsp',
          'Granola — ¼ cup',
          'Chia seeds — 1 tsp',
        ],
        steps: [
          'Blend banana, berries and yogurt.',
          'Pour into bowl.',
          'Top with granola and fruits.',
          'Drizzle honey on top.',
          'Serve immediately.',
        ],
      ),
      RecipeModel(
        name: 'Avocado Toast',
        duration: '10 mins',
        difficulty: 'Easy',
        emoji: '🥑',
        image: '🥑',
        isFavorite: false,
        category: 'Breakfast',
        serves: 1,
        ingredients: [
          'Bread — 2 slices',
          'Avocado — 1 pcs',
          'Lemon — ½ pcs',
          'Salt — pinch',
          'Chili flakes — pinch',
          'Egg — 1 pcs (optional)',
        ],
        steps: [
          'Toast bread slices.',
          'Mash avocado with lemon.',
          'Spread on toast.',
          'Season with salt & chili.',
          'Add egg on top if desired.',
        ],
      ),
    ];
  }
}
