class Item {
  final String id;
  final String name;
  final String description;
  final double salesPrice;
  final double purchasePrice;
  final String category;
  final String unit;
  final int stockQuantity;
  final DateTime createdAt;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.salesPrice,
    required this.purchasePrice,
    required this.category,
    required this.unit,
    required this.stockQuantity,
    required this.createdAt,
  });

  bool get isLowStock => stockQuantity < 10;
  bool get isOutOfStock => stockQuantity <= 0;

  // Sample items for testing
  static List<Item> getSampleItems() {
    return [
      Item(
        id: '1',
        name: 'Butter',
        description: 'Amul Butter 500gm',
        salesPrice: 220,
        purchasePrice: 190,
        category: 'Food',
        unit: 'BOX',
        stockQuantity: 5,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Item(
        id: '2',
        name: 'Milk',
        description: 'Fresh Farm Milk 1L',
        salesPrice: 60,
        purchasePrice: 45,
        category: 'Beverages',
        unit: 'PKT',
        stockQuantity: 20,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Item(
        id: '3',
        name: 'Ice Cream',
        description: 'Vanilla Ice Cream 1L',
        salesPrice: 180,
        purchasePrice: 150,
        category: 'Desserts',
        unit: 'BOX',
        stockQuantity: 0,
        createdAt: DateTime.now(),
      ),
      Item(
        id: '4',
        name: 'Cheese',
        description: 'Mozzarella Cheese 200g',
        salesPrice: 120,
        purchasePrice: 90,
        category: 'Food',
        unit: 'PKT',
        stockQuantity: 8,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }
}
