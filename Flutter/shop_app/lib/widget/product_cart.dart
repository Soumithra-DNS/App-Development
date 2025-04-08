import 'package:flutter/material.dart';

/// A reusable UI card widget for displaying a product's
/// title, price, and image with a customizable background.
class ProductCard extends StatelessWidget {
  final String productTitle;
  final double productPrice;
  final String imagePath;
  final Color cardBackgroundColor;

  const ProductCard({
    super.key,
    required this.productTitle,
    required this.productPrice,
    required this.imagePath,
    required this.cardBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: cardBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display product title
          Text(productTitle, style: Theme.of(context).textTheme.titleMedium),

          const SizedBox(height: 5),

          // Display product price
          Text('\$$productPrice', style: Theme.of(context).textTheme.bodySmall),

          const SizedBox(height: 5),

          // Display product image
          Image.asset(imagePath, height: 175),
        ],
      ),
    );
  }
}
