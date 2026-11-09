import '../models/ingredient_model.dart';
export '../models/ingredient_model.dart';

/// Comprehensive sample ingredients repository categorized for Kitchen Helper.
class SampleIngredients {
  static const List<String> categories = [
    'All',
    'Vegetables',
    'Fruits',
    'Dairy & Eggs',
    'Meat & Poultry',
    'Pantry & Grains',
    'Spices & Herbs',
  ];

  static List<IngredientModel> get vegetables => [
        IngredientModel(name: 'Tomato', quantity: '5 pcs', emoji: '🍅', isChecked: true),
        IngredientModel(name: 'Onion', quantity: '3 pcs', emoji: '🧅', isChecked: true),
        IngredientModel(name: 'Potato', quantity: '4 pcs', emoji: '🥔', isChecked: true),
        IngredientModel(name: 'Garlic', quantity: '1 bulb', emoji: '🧄', isChecked: false),
        IngredientModel(name: 'Spinach', quantity: '1 bunch', emoji: '🥬', isChecked: false),
        IngredientModel(name: 'Carrot', quantity: '3 pcs', emoji: '🥕', isChecked: false),
        IngredientModel(name: 'Bell Pepper', quantity: '2 pcs', emoji: '🫑', isChecked: false),
        IngredientModel(name: 'Capsicum', quantity: '1 pcs', emoji: '🌶️', isChecked: false),
        IngredientModel(name: 'Cucumber', quantity: '2 pcs', emoji: '🥒', isChecked: false),
        IngredientModel(name: 'Broccoli', quantity: '1 head', emoji: '🥦', isChecked: false),
        IngredientModel(name: 'Mushroom', quantity: '250 g', emoji: '🍄', isChecked: false),
      ];

  static List<IngredientModel> get fruits => [
        IngredientModel(name: 'Apple', quantity: '4 pcs', emoji: '🍎', isChecked: false),
        IngredientModel(name: 'Banana', quantity: '6 pcs', emoji: '🍌', isChecked: false),
        IngredientModel(name: 'Lemon', quantity: '3 pcs', emoji: '🍋', isChecked: false),
        IngredientModel(name: 'Orange', quantity: '4 pcs', emoji: '🍊', isChecked: false),
        IngredientModel(name: 'Strawberries', quantity: '200 g', emoji: '🍓', isChecked: false),
        IngredientModel(name: 'Avocado', quantity: '2 pcs', emoji: '🥑', isChecked: false),
      ];

  static List<IngredientModel> get dairyAndEggs => [
        IngredientModel(name: 'Milk', quantity: '1 liter', emoji: '🥛', isChecked: false),
        IngredientModel(name: 'Eggs', quantity: '6 pcs', emoji: '🥚', isChecked: false),
        IngredientModel(name: 'Cheese', quantity: '200 g', emoji: '🧀', isChecked: false),
        IngredientModel(name: 'Butter', quantity: '250 g', emoji: '🧈', isChecked: false),
        IngredientModel(name: 'Yogurt', quantity: '500 g', emoji: '🥣', isChecked: false),
      ];

  static List<IngredientModel> get meats => [
        IngredientModel(name: 'Chicken Breast', quantity: '500 g', emoji: '🍗', isChecked: false),
        IngredientModel(name: 'Minced Beef', quantity: '500 g', emoji: '🥩', isChecked: false),
        IngredientModel(name: 'Fish Fillet', quantity: '400 g', emoji: '🐟', isChecked: false),
        IngredientModel(name: 'Prawns', quantity: '300 g', emoji: '🦐', isChecked: false),
      ];

  static List<IngredientModel> get pantryAndGrains => [
        IngredientModel(name: 'Basmati Rice', quantity: '2 cups', emoji: '🍚', isChecked: false),
        IngredientModel(name: 'Pasta / Spaghetti', quantity: '500 g', emoji: '🍝', isChecked: false),
        IngredientModel(name: 'Bread', quantity: '1 loaf', emoji: '🍞', isChecked: false),
        IngredientModel(name: 'Flour', quantity: '1 kg', emoji: '🌾', isChecked: false),
        IngredientModel(name: 'Olive Oil', quantity: '500 ml', emoji: '🫒', isChecked: false),
        IngredientModel(name: 'Soy Sauce', quantity: '250 ml', emoji: '🍶', isChecked: false),
      ];

  static List<IngredientModel> get spicesAndHerbs => [
        IngredientModel(name: 'Black Pepper', quantity: '50 g', emoji: '🧂', isChecked: false),
        IngredientModel(name: 'Salt', quantity: '1 pack', emoji: '🧂', isChecked: false),
        IngredientModel(name: 'Turmeric Powder', quantity: '100 g', emoji: '🌿', isChecked: false),
        IngredientModel(name: 'Red Chili Flakes', quantity: '50 g', emoji: '🌶️', isChecked: false),
        IngredientModel(name: 'Fresh Mint', quantity: '1 bunch', emoji: '🌿', isChecked: false),
        IngredientModel(name: 'Coriander', quantity: '1 bunch', emoji: '🌿', isChecked: false),
      ];

  /// Returns all ingredients combined.
  static List<IngredientModel> getAll() {
    return [
      ...vegetables,
      ...dairyAndEggs,
      ...meats,
      ...pantryAndGrains,
      ...fruits,
      ...spicesAndHerbs,
    ];
  }

  /// Filter ingredients by category name.
  static List<IngredientModel> getByCategory(String category) {
    switch (category) {
      case 'Vegetables':
        return vegetables;
      case 'Fruits':
        return fruits;
      case 'Dairy & Eggs':
        return dairyAndEggs;
      case 'Meat & Poultry':
        return meats;
      case 'Pantry & Grains':
        return pantryAndGrains;
      case 'Spices & Herbs':
        return spicesAndHerbs;
      case 'All':
      default:
        return getAll();
    }
  }

  /// Initial shopping list presets.
  static List<IngredientModel> getShoppingList() {
    return IngredientsData.getShoppingList();
  }

  /// Initial purchased list presets.
  static List<IngredientModel> getPurchasedList() {
    return IngredientsData.getPurchasedList();
  }
}
