import 'package:flutter/material.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/widget/product_list.dart';

/// The main screen of the shopping app.
/// Displays product list and cart page using bottom navigation.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Index of the currently selected page (0 = home, 1 = cart).
  int selectedPageIndex = 0;

  // List of pages that will be displayed in the body.
  final List<Widget> screenPages = const [
    ProductList(), // Product listing page
    CartPage(), // Shopping cart page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Keeps all pages alive but only shows the selected one.
      body: IndexedStack(index: selectedPageIndex, children: screenPages),

      // Bottom navigation bar to switch between home and cart.
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: selectedPageIndex,
        onTap: (index) {
          // Update the selected index to switch views.
          setState(() {
            selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
        ],
      ),
    );
  }
}
