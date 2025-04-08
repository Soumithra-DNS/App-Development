import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

/// A page that displays detailed information about a selected product.
/// Allows the user to choose a size and add the product to their cart.
class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // Stores the size selected by the user.
  int selectedProductSize = 0;

  /// Adds the product to the cart if a size is selected.
  /// Shows a SnackBar message based on whether the size is selected or not.
  void handleAddToCart() {
    if (selectedProductSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imageUrl': widget.product['imageUrl'],
        'company': widget.product['company'],
        'size': selectedProductSize,
      });

      // Confirmation message when product is added
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );
    } else {
      // Warning message if no size is selected
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a size!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Product title
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const Spacer(flex: 1),

          // Product image
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              widget.product['imageUrl'] as String,
              height: 250,
            ),
          ),

          const Spacer(flex: 2),

          // Bottom container showing price, sizes, and "Add to Cart" button
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 204, 214, 224),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                // Product price
                Text(
                  '\$${widget.product['price']}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),

                // List of available sizes as selectable chips
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final availableSize =
                          (widget.product['sizes'] as List<int>)[index];

                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedProductSize = availableSize;
                            });
                          },
                          child: Chip(
                            label: Text(
                              availableSize.toString(),
                              style: const TextStyle(fontSize: 17),
                            ),
                            backgroundColor:
                                selectedProductSize == availableSize
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // "Add to Cart" button
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: handleAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      maximumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Add To Cart',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
