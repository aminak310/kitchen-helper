class IngredientModel {
  final String name;
  final String quantity;
  final String emoji;
  bool isChecked;

  IngredientModel({
    required this.name,
    required this.quantity,
    required this.emoji,
    this.isChecked = false,
  });
}

// Sample data
class IngredientsData {
  static List<IngredientModel> getAllIngredients() {
    return [
      IngredientModel(name: 'Tomato', quantity: '5 pcs', emoji: '🍅', isChecked: true),
      IngredientModel(name: 'Onion', quantity: '3 pcs', emoji: '🧅', isChecked: true),
      IngredientModel(name: 'Potato', quantity: '4 pcs', emoji: '🥔', isChecked: true),
      IngredientModel(name: 'Garlic', quantity: '1 bulb', emoji: '🧄', isChecked: false),
      IngredientModel(name: 'Spinach', quantity: '1 bunch', emoji: '🥬', isChecked: false),
      IngredientModel(name: 'Carrot', quantity: '3 pcs', emoji: '🥕', isChecked: false),
      IngredientModel(name: 'Bell Pepper', quantity: '2 pcs', emoji: '🫑', isChecked: true),
      IngredientModel(name: 'Capsicum', quantity: '1 pcs', emoji: '🌶️', isChecked: false),
      IngredientModel(name: 'Broccoli', quantity: '1 head', emoji: '🥦', isChecked: false),
      IngredientModel(name: 'Cucumber', quantity: '2 pcs', emoji: '🥒', isChecked: true),
      IngredientModel(name: 'Mushroom', quantity: '250 g', emoji: '🍄', isChecked: false),
      IngredientModel(name: 'Ginger', quantity: '100 g', emoji: '🫚', isChecked: true),
      IngredientModel(name: 'Green Peas', quantity: '1 cup', emoji: '🫛', isChecked: false),
      IngredientModel(name: 'Apple', quantity: '4 pcs', emoji: '🍎', isChecked: true),
      IngredientModel(name: 'Banana', quantity: '6 pcs', emoji: '🍌', isChecked: true),
      IngredientModel(name: 'Lemon', quantity: '3 pcs', emoji: '🍋', isChecked: false),
      IngredientModel(name: 'Mango', quantity: '2 pcs', emoji: '🥭', isChecked: false),
      IngredientModel(name: 'Strawberries', quantity: '250 g', emoji: '🍓', isChecked: false),
      IngredientModel(name: 'Blueberries', quantity: '150 g', emoji: '🫐', isChecked: false),
      IngredientModel(name: 'Avocado', quantity: '2 pcs', emoji: '🥑', isChecked: true),
      IngredientModel(name: 'Milk', quantity: '1 liter', emoji: '🥛', isChecked: true),
      IngredientModel(name: 'Butter', quantity: '250 g', emoji: '🧈', isChecked: true),
      IngredientModel(name: 'Cheese', quantity: '200 g', emoji: '🧀', isChecked: false),
      IngredientModel(name: 'Yogurt', quantity: '500 g', emoji: '🥣', isChecked: true),
      IngredientModel(name: 'Heavy Cream', quantity: '250 ml', emoji: '🥛', isChecked: false),
      IngredientModel(name: 'Chicken', quantity: '500 g', emoji: '🍗', isChecked: false),
      IngredientModel(name: 'Eggs', quantity: '6 pcs', emoji: '🥚', isChecked: true),
      IngredientModel(name: 'Minced Beef', quantity: '500 g', emoji: '🥩', isChecked: false),
      IngredientModel(name: 'Fish Fillet', quantity: '400 g', emoji: '🐟', isChecked: false),
      IngredientModel(name: 'Rice', quantity: '2 cups', emoji: '🍚', isChecked: true),
      IngredientModel(name: 'Pasta', quantity: '500 g', emoji: '🍝', isChecked: false),
      IngredientModel(name: 'Bread', quantity: '1 loaf', emoji: '🍞', isChecked: true),
      IngredientModel(name: 'Flour', quantity: '1 kg', emoji: '🌾', isChecked: true),
      IngredientModel(name: 'Olive Oil', quantity: '500 ml', emoji: '🫒', isChecked: true),
      IngredientModel(name: 'Honey', quantity: '250 g', emoji: '🍯', isChecked: false),
      IngredientModel(name: 'Black Pepper', quantity: '50 g', emoji: '🧂', isChecked: true),
    ];
  }

  static List<IngredientModel> getShoppingList() {
    return [
      IngredientModel(name: 'Milk', quantity: '1 liter', emoji: '🥛'),
      IngredientModel(name: 'Eggs', quantity: '6 pcs', emoji: '🥚'),
      IngredientModel(name: 'Bread', quantity: '1 loaf', emoji: '🍞'),
      IngredientModel(name: 'Cheese', quantity: '200 g', emoji: '🧀'),
      IngredientModel(name: 'Bell Pepper', quantity: '3 pcs', emoji: '🫑'),
      IngredientModel(name: 'Lettuce', quantity: '1 bunch', emoji: '🥬'),
    ];
  }

  static List<IngredientModel> getPurchasedList() {
    return [
      IngredientModel(name: 'Tomato', quantity: '5 pcs', emoji: '🍅', isChecked: true),
      IngredientModel(name: 'Onion', quantity: '3 pcs', emoji: '🧅', isChecked: true),
      IngredientModel(name: 'Potato', quantity: '4 pcs', emoji: '🥔', isChecked: true),
    ];
  }
}
