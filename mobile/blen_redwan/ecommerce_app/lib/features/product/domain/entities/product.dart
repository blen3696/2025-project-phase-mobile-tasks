class Product {
  final int id;
  final String name;
  final double price;
  final String category;
  final String image;
  final String description;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    required this.description,
    required this.rating,
  });

  factory Product.empty() => Product(
    id: -1,
    name: '',
    price: 0.0,
    category: '',
    image: '',
    description: '',
    rating: 0.0,
  );
}
