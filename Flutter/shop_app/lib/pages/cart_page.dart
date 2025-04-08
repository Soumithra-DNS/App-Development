import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Method to show a confirmation dialog before removing an item
  Future<void> _showDeleteConfirmationDialog(
    BuildContext context,
    Map<String, dynamic> item,
  ) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete Product',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: const Text('Are you sure you want to remove the product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Dismiss dialog
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<CartProvider>().removeProduct(
                  item,
                ); // Remove item from cart
                Navigator.of(context).pop(); // Dismiss dialog
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<CartProvider>().cartItems;

    // Calculate total price
    double totalPrice = 0.0;
    for (var item in cartItems) {
      totalPrice += item['price'] as double;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body:
          cartItems.isEmpty
              ? Center(
                child: Text(
                  'No items in the cart',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
              : Column(
                children: [
                  // Cart items list
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return _CartItemTile(
                          item: item,
                          onDelete:
                              () =>
                                  _showDeleteConfirmationDialog(context, item),
                        );
                      },
                    ),
                  ),
                  // Total price section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: \$${totalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle checkout logic
                          },
                          child: const Text(
                            'Checkout',
                            style: TextStyle(color: Colors.black),
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

class _CartItemTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onDelete;

  const _CartItemTile({required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          item['imageUrl'] ?? 'assets/images/default.png',
        ), // Default fallback if image URL is missing
        radius: 30,
      ),
      trailing: IconButton(
        onPressed: onDelete,
        icon: const Icon(Icons.delete, color: Colors.red),
      ),
      title: Text(
        item['title'].toString(),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Size: ${item['size']}',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
