import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';

void main() {
  group('ProductModel', () {
    final productJson = {
      'id': 1,
      'name': 'Shoe',
      'description': 'Nice shoe',
      'image': 'shoe.jpg',
      'price': 99.99,
      'rating': 4.5,
      'category': 'Footwear',
    };

    final productModel = ProductModel(
      id: 1,
      name: 'Shoe',
      description: 'Nice shoe',
      image: 'shoe.jpg',
      price: 99.99,
      rating: 4.5,
      category: 'Footwear',
    );

    test('fromJson returns correct model', () {
      final result = ProductModel.fromJson(productJson);
      expect(result.id, productModel.id);
      expect(result.name, productModel.name);
      expect(result.description, productModel.description);
      expect(result.image, productModel.image);
      expect(result.price, productModel.price);
      expect(result.rating, productModel.rating);
      expect(result.category, productModel.category);
    });

    test('toJson returns correct map', () {
      expect(productModel.toJson(), productJson);
    });
  });
}
