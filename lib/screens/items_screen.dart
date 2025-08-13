import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/item.dart';
import 'create_item_screen.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  // Theme colors
  static const Color primaryColor = Color(0xFF2E3085);
  static const Color secondaryColor = Color(0xFF4E4AA8);

  List<Item> _items = [];
  String _selectedCategory = 'All Items';
  String _selectedStockFilter = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    // Sample data
    _items = [
      Item(
        id: '1',
        name: 'Margherita Pizza',
        description: 'Classic Margherita Pizza',
        salesPrice: 12.99,
        purchasePrice: 8.99,
        category: 'Pizza',
        unit: 'pieces',
        stockQuantity: 50,
        createdAt: DateTime.now(),
      ),
      Item(
        id: '2',
        name: 'Chicken Burger',
        description: 'Grilled Chicken Burger',
        salesPrice: 8.99,
        purchasePrice: 5.99,
        category: 'Burgers',
        unit: 'pieces',
        stockQuantity: 30,
        createdAt: DateTime.now(),
      ),
      Item(
        id: '3',
        name: 'French Fries',
        description: 'Crispy French Fries',
        salesPrice: 4.99,
        purchasePrice: 2.99,
        category: 'Sides',
        unit: 'servings',
        stockQuantity: 100,
        createdAt: DateTime.now(),
      ),
      Item(
        id: '4',
        name: 'Coca Cola',
        description: 'Refreshing Coca Cola',
        salesPrice: 2.99,
        purchasePrice: 1.99,
        category: 'Beverages',
        unit: 'bottles',
        stockQuantity: 200,
        createdAt: DateTime.now(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _getFilteredItems();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child:
                filteredItems.isEmpty
                    ? _buildEmptyState()
                    : _buildItemsList(filteredItems),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateItemScreen()),
            );
          },
          backgroundColor: primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
          icon: const Icon(
            Icons.add_circle_outline,
            size: 20,
            color: Colors.white,
          ),
          label: const Text(
            'Create New Item',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Items',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 0.1,
              color: Colors.black87,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.grey, size: 24),
              onPressed: () {
                // Handle search
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.white,
      child: Row(
        children: [
          // Low Stock Toggle
          FilterChip(
            label: const Text('Low Stock', style: TextStyle(fontSize: 13)),
            selected: false, // This state variable is not used in the new code
            onSelected: (bool value) {
              // setState(() {
              //   _showLowStock = value;
              // });
            },
            backgroundColor: Colors.white,
            selectedColor: primaryColor.withOpacity(0.1),
            checkmarkColor: primaryColor,
            labelStyle: TextStyle(
              color:
                  false
                      ? primaryColor
                      : Colors
                          .grey[800], // This state variable is not used in the new code
              fontWeight:
                  false
                      ? FontWeight.w500
                      : FontWeight
                          .normal, // This state variable is not used in the new code
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color:
                    false
                        ? primaryColor
                        : Colors.grey.withOpacity(
                          0.3,
                        ), // This state variable is not used in the new code
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Category Dropdown
          Expanded(
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 20,
                  elevation: 1,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items:
                      <String>[
                        'All Items',
                        'Food',
                        'Beverages',
                        'Desserts',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Filter Button
          InkWell(
            onTap: () {
              _showFilterDialog(context);
            },
            child: Container(
              height: 32,
              width: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.tune, size: 18, color: Colors.grey[700]),
                  const SizedBox(width: 4),
                  Text(
                    'All',
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(List<Item> items) {
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: 80, // Add bottom padding to prevent FAB overlap
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildItemCard(item);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No items found. Add a new item!',
        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildItemCard(Item item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[300]!, Colors.grey[500]!],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'S',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${item.stockQuantity.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.unit.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sales Price',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '₹ ${item.salesPrice}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Purchase Price',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '₹ ${item.purchasePrice}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(Icons.tune, size: 16, color: primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom +
                MediaQuery.of(context).padding.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sort by',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      ['A-Z', 'Z-A', 'Price: Low to High', 'Price: High to Low']
                          .map(
                            (sort) => ChoiceChip(
                              label: Text(sort),
                              selected: false,
                              onSelected: (bool selected) {
                                // TODO: Implement sorting logic
                              },
                            ),
                          )
                          .toList(),
                ),
                SizedBox(height: 24),
                Text(
                  'Filter by',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      ['All Items', 'Low Stock', 'In Stock', 'Not in Stock']
                          .map(
                            (filter) => ChoiceChip(
                              label: Text(filter),
                              selected: false,
                              onSelected: (bool selected) {
                                // TODO: Implement filtering logic
                              },
                            ),
                          )
                          .toList(),
                ),
                SizedBox(height: 16),
                SwitchListTile(
                  title: Text('In Online Store'),
                  value: false,
                  onChanged: (bool value) {
                    // TODO: Implement online store filter
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Item> _getFilteredItems() {
    List<Item> filteredItems = List.from(_items);

    // Apply category filter
    if (_selectedCategory != 'All Items') {
      filteredItems =
          filteredItems
              .where((item) => item.category == _selectedCategory)
              .toList();
    }

    // Apply stock filter
    // switch (_stockFilter) { // This state variable is not used in the new code
    //   case 'Low Stock':
    //     filteredItems = filteredItems.where((item) => item.isLowStock).toList();
    //     break;
    //   case 'In Stock':
    //     filteredItems =
    //         filteredItems.where((item) => item.stockQuantity > 0).toList();
    //     break;
    //   case 'Not in Stock':
    //     filteredItems =
    //         filteredItems.where((item) => item.stockQuantity <= 0).toList();
    //     break;
    // }

    // Apply online store filter
    // if (_isOnlineStore) { // This state variable is not used in the new code
    //   // Add your online store filtering logic here
    //   // For example: filteredItems = filteredItems.where((item) => item.isOnlineEnabled).toList();
    // }

    // Apply sorting
    // switch (_sortBy) { // This state variable is not used in the new code
    //   case 'A-Z':
    //     filteredItems.sort((a, b) => a.name.compareTo(b.name));
    //     break;
    //   case 'Z-A':
    //     filteredItems.sort((a, b) => b.name.compareTo(a.name));
    //     break;
    //   case 'Price: Low to High':
    //     filteredItems.sort((a, b) => a.salesPrice.compareTo(b.salesPrice));
    //     break;
    //   case 'Price: High to Low':
    //     filteredItems.sort((a, b) => b.salesPrice.compareTo(a.salesPrice));
    //     break;
    // }

    return filteredItems;
  }

  @override
  void dispose() {
    // _searchController.dispose(); // This controller is not used in the new code
    super.dispose();
  }
}
