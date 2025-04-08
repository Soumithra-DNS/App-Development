/// List of products available in the store.
/// Each product is represented by a map containing details like title, price, company, sizes, etc.
final List<Map<String, dynamic>> products = [
  {
    'id': '0', // Unique identifier for the product
    'title': 'Men\'s Nike Shoes', // Product name
    'price': 44.52, // Price of the product
    'imageUrl': 'assets/images/shoes_1.png', // Path to the product image
    'company': 'Nike', // Brand of the product
    'sizes': [9, 10, 11, 12], // Available sizes for the product
  },
  {
    'id': '1',
    'title': 'Addidas Shoes',
    'price': 20.12,
    'imageUrl': 'assets/images/shoes_2.png',
    'company': 'Addidas',
    'sizes': [9, 10, 12],
  },
  {
    'id': '2',
    'title': 'Bata Women\'s Shoes',
    'price': 28.95,
    'imageUrl': 'assets/images/shoes_3.png',
    'company': 'Bata',
    'sizes': [8, 9, 10],
  },
  {
    'id': '3',
    'title': 'Jordan Shoes',
    'price': 420.69,
    'imageUrl': 'assets/images/shoes_4.png',
    'company': 'Nike',
    'sizes': [8, 9, 10],
  },
];
