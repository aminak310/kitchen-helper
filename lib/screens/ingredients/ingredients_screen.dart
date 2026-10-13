import 'package:flutter/material.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  int _selectedFilter = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'All',
    'Vegetables',
    'Fruits',
    'Dairy',
    'Others',
  ];

  // Ingredients: name, qty, image path or null (uses emoji), emoji, isChecked
  final List<Map<String, dynamic>> _ingredients = [
    {
      'name': 'Tomato',
      'qty': '5 pcs',
      'asset': 'assets/images/ing_tomato.png',
      'emoji': '🍅',
      'color': const Color(0xFFFFECEC),
      'checked': true,
      'category': 'Vegetables',
    },
    {
      'name': 'Onion',
      'qty': '3 pcs',
      'asset': 'assets/images/ing_onion.png',
      'emoji': '🧅',
      'color': const Color(0xFFF5E8FF),
      'checked': true,
      'category': 'Vegetables',
    },
    {
      'name': 'Potato',
      'qty': '4 pcs',
      'asset': null,
      'emoji': '🥔',
      'color': const Color(0xFFFFF8E1),
      'checked': true,
      'category': 'Vegetables',
    },
    {
      'name': 'Garlic',
      'qty': '1 bulb',
      'asset': null,
      'emoji': '🧄',
      'color': const Color(0xFFF5F5DC),
      'checked': false,
      'category': 'Vegetables',
    },
    {
      'name': 'Spinach',
      'qty': '1 bunch',
      'asset': null,
      'emoji': '🥬',
      'color': const Color(0xFFE8F5E9),
      'checked': false,
      'category': 'Vegetables',
    },
    {
      'name': 'Chicken',
      'qty': '500 g',
      'asset': null,
      'emoji': '🍗',
      'color': const Color(0xFFFFF3E0),
      'checked': false,
      'category': 'Others',
    },
    {
      'name': 'Milk',
      'qty': '1 liter',
      'asset': null,
      'emoji': '🥛',
      'color': const Color(0xFFE3F2FD),
      'checked': false,
      'category': 'Dairy',
    },
    {
      'name': 'Eggs',
      'qty': '6 pcs',
      'asset': null,
      'emoji': '🥚',
      'color': const Color(0xFFFFF9C4),
      'checked': false,
      'category': 'Others',
    },
    {
      'name': 'Carrot',
      'qty': '3 pcs',
      'asset': null,
      'emoji': '🥕',
      'color': const Color(0xFFFFECB3),
      'checked': false,
      'category': 'Vegetables',
    },
  ];

  List<Map<String, dynamic>> get _filteredIngredients {
    final query = _searchController.text.toLowerCase();
    return _ingredients.where((item) {
      final matchesFilter = _selectedFilter == 0 ||
          item['category'] == _filters[_selectedFilter];
      final matchesSearch =
          query.isEmpty || item['name'].toLowerCase().contains(query);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          'My Ingredients',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A2E1F),
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: _showAddDialog,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D52),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
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
                  hintText: 'Search ingredients...',
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

          // ── Filter Chips ──
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final selected = _selectedFilter == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = index),
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
                      _filters[index],
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

          // ── Ingredients List ──
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              itemCount: _filteredIngredients.length,
              separatorBuilder: (_, _) => const Divider(
                color: Color(0xFFE0EDE5),
                height: 1,
              ),
              itemBuilder: (context, index) {
                final item = _filteredIngredients[index];
                final globalIndex = _ingredients.indexOf(item);
                return Dismissible(
                  key: Key('${item['name']}_$globalIndex'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.redAccent.withValues(alpha: 0.1),
                    child: const Icon(Icons.delete_outline_rounded,
                        color: Colors.redAccent),
                  ),
                  onDismissed: (_) {
                    setState(() => _ingredients.removeAt(globalIndex));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item['name']} removed'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: _IngredientTile(
                    item: item,
                    onToggle: () {
                      setState(() {
                        _ingredients[globalIndex]['checked'] =
                            !_ingredients[globalIndex]['checked'];
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDialog() {
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    String selectedCategory = 'Vegetables';
    final categories = ['Vegetables', 'Fruits', 'Dairy', 'Others'];
    final emojis = {
      'Vegetables': '🥦',
      'Fruits': '🍎',
      'Dairy': '🥛',
      'Others': '🛒',
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            left: 24,
            right: 24,
            top: 24,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Ingredient',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: Color(0xFF1A2E1F),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Ingredient name (e.g. Garlic)',
                  filled: true,
                  fillColor: const Color(0xFFF2F4E6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: qtyCtrl,
                decoration: InputDecoration(
                  hintText: 'Quantity (e.g. 3 pcs)',
                  filled: true,
                  fillColor: const Color(0xFFF2F4E6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Category Picker
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A6355),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: categories.map((cat) {
                  final isSelected = selectedCategory == cat;
                  return GestureDetector(
                    onTap: () =>
                        setModalState(() => selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF2E7D52)
                            : const Color(0xFFF2F4E6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF8FAF9A),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final name = nameCtrl.text.trim();
                    if (name.isNotEmpty) {
                      setState(() {
                        _ingredients.add({
                          'name': name,
                          'qty': qtyCtrl.text.trim().isEmpty
                              ? '1 unit'
                              : qtyCtrl.text.trim(),
                          'asset': null,
                          'emoji': emojis[selectedCategory] ?? '🛒',
                          'color': _categoryColor(selectedCategory),
                          'checked': false,
                          'category': selectedCategory,
                        });
                      });
                      Navigator.pop(ctx);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Add Ingredient',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Vegetables':
        return const Color(0xFFE8F5E9);
      case 'Fruits':
        return const Color(0xFFFFECEC);
      case 'Dairy':
        return const Color(0xFFE3F2FD);
      default:
        return const Color(0xFFF5F5DC);
    }
  }
}

// ── Ingredient Tile ──
class _IngredientTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onToggle;

  const _IngredientTile({required this.item, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final bool isChecked = item['checked'] as bool;
    final String? asset = item['asset'] as String?;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Image or emoji tile
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 56,
              height: 56,
              color: item['color'] as Color,
              child: asset != null
                  ? Image.asset(asset, fit: BoxFit.cover)
                  : Center(
                      child: Text(
                        item['emoji'] as String,
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 14),

          // Name + qty
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A2E1F),
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['qty'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8FAF9A),
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),

          // Checkbox
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: isChecked
                    ? const Color(0xFF2E7D52)
                    : Colors.transparent,
                border: Border.all(
                  color: isChecked
                      ? const Color(0xFF2E7D52)
                      : const Color(0xFFB8D9C8),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: isChecked
                  ? const Icon(Icons.check_rounded,
                      color: Colors.white, size: 16)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
