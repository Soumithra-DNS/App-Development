import 'package:flutter/material.dart';

/// Provides state management for the shopping cart.
/// Allows adding and removing products, with notifications to listeners.
class CartProvider extends ChangeNotifier {
  /// List holding the items in the cart
  final List<Map<String, dynamic>> _cartItems = [];

  /// Retrieves the current list of items in the cart
  List<Map<String, dynamic>> get cartItems => [..._cartItems];

  /// Adds a product to the cart
  /// [product] is a map containing product details like id, title, price, etc.
  void addProduct(Map<String, dynamic> product) {
    _cartItems.add(product);
    notifyListeners();  // Notify listeners about the state change
  }

  /// Removes a product from the cart
  /// [product] is the map containing the product details to be removed
  void removeProduct(Map<String, dynamic> product) {
    _cartItems.remove(product);
    notifyListeners();  // Notify listeners about the state change
  }
}
