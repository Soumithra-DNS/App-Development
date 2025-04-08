import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/widget/product_cart.dart';
import 'package:shop_app/pages/product_details_page.dart';

/// Displays a searchable and filterable list of products.
/// Supports responsive layout for larger screens (grid) and smaller screens (list).
class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // List of available product filters
  final List<String> availableFilters = const ['All', 'Adidas', 'Nike', 'Bata'];

  // Currently selected filter
  late String activeFilter;

  @override
  void initState() {
    super.initState();
    activeFilter = availableFilters[0]; // Default to 'All'
  }

  @override
  Widget build(BuildContext context) {
    // Common border styling for the search box
    const inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(40)),
    );

    return SafeArea(
      child: Column(
        children: [
          /// Header with title and search field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  'Shoes\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: inputBorder,
                      enabledBorder: inputBorder,
                      focusedBorder: inputBorder,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Horizontal filter chips
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: availableFilters.length,
              itemBuilder: (context, index) {
                final filterLabel = availableFilters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeFilter = filterLabel;
                      });
                    },
                    child: Chip(
                      backgroundColor:
                          activeFilter == filterLabel
                              ? Theme.of(context).colorScheme.primary
                              : const Color.fromARGB(255, 220, 217, 217),
                      side: const BorderSide(
                        color: Color.fromRGBO(255, 249, 249, 1),
                      ),
                      label: Text(filterLabel),
                      labelStyle: const TextStyle(fontSize: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Product list or grid based on screen width
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWideScreen = constraints.maxWidth > 1080;

                return isWideScreen
                    ? GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                          ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return _buildProductTile(context, product, index);
                      },
                    )
                    : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return _buildProductTile(context, product, index);
                      },
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable method to build a product card with navigation
  Widget _buildProductTile(
    BuildContext context,
    Map<String, dynamic> product, // Keep this as Map<String, dynamic>
    int index,
  ) {
    // Cast product to Map<String, Object>
    final Map<String, Object> productObject = product.cast<String, Object>();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: productObject),
          ),
        );
      },
      child: ProductCard(
        productTitle: productObject['title'] as String,
        productPrice: productObject['price'] as double,
        imagePath: productObject['imageUrl'] as String,
        cardBackgroundColor:
            index.isEven
                ? const Color.fromRGBO(223, 225, 225, 1)
                : const Color.fromRGBO(207, 233, 249, 1),
      ),
    );
  }
}
