import 'package:flutter/material.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  int _selectedTabIndex = 0; // 0: Needed Items, 1: Purchased

  final List<Map<String, dynamic>> _neededItems = [
    {
      'name': 'Milk',
      'qty': '1 liter',
      'emoji': '🥛',
      'bgColor': const Color(0xFFF1F6FB),
      'checked': false,
    },
    {
      'name': 'Eggs',
      'qty': '6 pcs',
      'emoji': '🥚',
      'bgColor': const Color(0xFFFFF9E6),
      'checked': false,
    },
    {
      'name': 'Bread',
      'qty': '1 loaf',
      'emoji': '🍞',
      'bgColor': const Color(0xFFFFF4E8),
      'checked': false,
    },
    {
      'name': 'Cheese',
      'qty': '200 g',
      'emoji': '🧀',
      'bgColor': const Color(0xFFFFFBE6),
      'checked': false,
    },
    {
      'name': 'Bell Pepper',
      'qty': '2 pcs',
      'emoji': '🫑',
      'bgColor': const Color(0xFFFBECEB),
      'checked': false,
    },
    {
      'name': 'Lettuce',
      'qty': '1 bunch',
      'emoji': '🥬',
      'bgColor': const Color(0xFFEEF7EE),
      'checked': false,
    },
    {
      'name': 'Chicken Breast',
      'qty': '500 g',
      'emoji': '🍗',
      'bgColor': const Color(0xFFFFF3E0),
      'checked': false,
    },
    {
      'name': 'Basmati Rice',
      'qty': '1 kg',
      'emoji': '🍚',
      'bgColor': const Color(0xFFF1F8E9),
      'checked': false,
    },
    {
      'name': 'Olive Oil',
      'qty': '500 ml',
      'emoji': '🫒',
      'bgColor': const Color(0xFFE8F5E9),
      'checked': false,
    },
    {
      'name': 'Strawberries',
      'qty': '250 g',
      'emoji': '🍓',
      'bgColor': const Color(0xFFFFCDD2),
      'checked': false,
    },
    {
      'name': 'Pasta',
      'qty': '500 g',
      'emoji': '🍝',
      'bgColor': const Color(0xFFFFF8E1),
      'checked': false,
    },
    {
      'name': 'Dark Chocolate',
      'qty': '100 g',
      'emoji': '🍫',
      'bgColor': const Color(0xFFEFEBE9),
      'checked': false,
    },
  ];

  final List<Map<String, dynamic>> _purchasedItems = [
    {
      'name': 'Tomato',
      'qty': '5 pcs',
      'emoji': '🍅',
      'bgColor': const Color(0xFFFFECEC),
      'checked': true,
    },
    {
      'name': 'Onion',
      'qty': '3 pcs',
      'emoji': '🧅',
      'bgColor': const Color(0xFFF5E8FF),
      'checked': true,
    },
    {
      'name': 'Potato',
      'qty': '4 pcs',
      'emoji': '🥔',
      'bgColor': const Color(0xFFFFF8E1),
      'checked': true,
    },
    {
      'name': 'Garlic',
      'qty': '1 bulb',
      'emoji': '🧄',
      'bgColor': const Color(0xFFF5F5DC),
      'checked': true,
    },
    {
      'name': 'Butter',
      'qty': '250 g',
      'emoji': '🧈',
      'bgColor': const Color(0xFFFFF8E1),
      'checked': true,
    },
    {
      'name': 'Carrot',
      'qty': '3 pcs',
      'emoji': '🥕',
      'bgColor': const Color(0xFFFFECB3),
      'checked': true,
    },
  ];

  void _markItemAsPurchased(int index) {
    setState(() {
      final item = Map<String, dynamic>.from(_neededItems.removeAt(index));
      item['checked'] = true;
      _purchasedItems.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item marked as purchased!'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _unmarkItem(int index) {
    setState(() {
      final item = Map<String, dynamic>.from(_purchasedItems.removeAt(index));
      item['checked'] = false;
      _neededItems.add(item);
    });
  }

  void _markAllPurchased() {
    setState(() {
      for (final item in _neededItems) {
        item['checked'] = true;
        _purchasedItems.add(Map<String, dynamic>.from(item));
      }
      _neededItems.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All items marked as purchased! 🎉'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showAddItemDialog() {
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Shopping Item',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E35),
                    fontFamily: 'Poppins',
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
                hintText: 'Item Name (e.g. Olive Oil, Garlic)',
                filled: true,
                fillColor: const Color(0xFFF9F7F1),
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
                hintText: 'Quantity (e.g. 500 ml, 2 pcs)',
                filled: true,
                fillColor: const Color(0xFFF9F7F1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (nameCtrl.text.trim().isNotEmpty) {
                    setState(() {
                      _neededItems.add({
                        'name': nameCtrl.text.trim(),
                        'qty': qtyCtrl.text.trim().isEmpty ? '1 unit' : qtyCtrl.text.trim(),
                        'emoji': '🛒',
                        'bgColor': const Color(0xFFF1F6FB),
                        'checked': false,
                      });
                    });
                    Navigator.pop(ctx);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Add to List',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFFAF8F3);
    const primaryGreen = Color(0xFF1B5E35);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: primaryGreen, size: 20),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'Shopping List',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: primaryGreen,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded, color: primaryGreen, size: 28),
            onPressed: _showAddItemDialog,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // ── Pill Segment Tabs (Exact match to design) ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Needed Items Pill
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTabIndex = 0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedTabIndex == 0
                            ? primaryGreen
                            : const Color(0xFFECEAE3),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: _selectedTabIndex == 0
                            ? [
                                BoxShadow(
                                  color: primaryGreen.withValues(alpha: 0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Needed Items',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: _selectedTabIndex == 0
                                  ? Colors.white
                                  : const Color(0xFF3F5E48),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _selectedTabIndex == 0
                                  ? Colors.white
                                  : const Color(0xFFDDD9CF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${_neededItems.length}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: _selectedTabIndex == 0
                                  ? primaryGreen
                                  : const Color(0xFF4C6A55),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Purchased Pill
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTabIndex = 1),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedTabIndex == 1
                            ? primaryGreen
                            : const Color(0xFFECEAE3),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: _selectedTabIndex == 1
                            ? [
                                BoxShadow(
                                  color: primaryGreen.withValues(alpha: 0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Purchased',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: _selectedTabIndex == 1
                                  ? Colors.white
                                  : const Color(0xFF3F5E48),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _selectedTabIndex == 1
                                  ? Colors.white
                                  : const Color(0xFFDDD9CF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${_purchasedItems.length}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: _selectedTabIndex == 1
                                  ? primaryGreen
                                  : const Color(0xFF4C6A55),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Items List ──
          Expanded(
            child: _selectedTabIndex == 0
                ? (_neededItems.isEmpty
                    ? _buildEmptyState('🎉', 'All items purchased!')
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        itemCount: _neededItems.length,
                        itemBuilder: (context, index) {
                          final item = _neededItems[index];
                          return _buildItemCard(
                            item: item,
                            isPurchased: false,
                            onToggle: () => _markItemAsPurchased(index),
                          );
                        },
                      ))
                : (_purchasedItems.isEmpty
                    ? _buildEmptyState('🛒', 'No purchased items yet')
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        itemCount: _purchasedItems.length,
                        itemBuilder: (context, index) {
                          final item = _purchasedItems[index];
                          return _buildItemCard(
                            item: item,
                            isPurchased: true,
                            onToggle: () => _unmarkItem(index),
                          );
                        },
                      )),
          ),

          // ── Mark All as Purchased Button ──
          if (_selectedTabIndex == 0 && _neededItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _markAllPurchased,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    elevation: 3,
                    shadowColor: primaryGreen.withValues(alpha: 0.35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline_rounded,
                          color: Colors.white, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Mark All as Purchased',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItemCard({
    required Map<String, dynamic> item,
    required bool isPurchased,
    required VoidCallback onToggle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Emoji / Food thumbnail
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: item['bgColor'] as Color? ?? const Color(0xFFF5F5F0),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                item['emoji'] as String,
                style: const TextStyle(fontSize: 26),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Name and Quantity
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: isPurchased
                        ? const Color(0xFFA5B8AB)
                        : const Color(0xFF1B2A1E),
                    decoration: isPurchased
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item['qty'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF8E9E93),
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),

          // Checkbox
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isPurchased ? const Color(0xFF1B5E35) : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: isPurchased
                      ? const Color(0xFF1B5E35)
                      : const Color(0xFFD4DFD7),
                  width: 1.8,
                ),
              ),
              child: isPurchased
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String emoji, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8E9E93),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
