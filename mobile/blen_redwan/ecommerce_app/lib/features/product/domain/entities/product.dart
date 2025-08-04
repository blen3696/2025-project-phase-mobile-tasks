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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      image: json['image'],
      description: json['description'],
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'category': category,
    'image': image,
    'description': description,
    'rating': rating,
  };

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
