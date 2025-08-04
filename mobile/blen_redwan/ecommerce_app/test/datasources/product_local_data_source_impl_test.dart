import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_local_data_source_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

void main() {
  late SharedPreferences prefs;
  late ProductLocalDataSourceImpl dataSource;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    dataSource = ProductLocalDataSourceImpl(sharedPreferences: prefs);
  });

  final product = Product(
    id: 1,
    name: 'Test Product',
    price: 99.99,
    category: 'Electronics',
    image: 'https://example.com/image.jpg',
    description: 'A nice test product.',
    rating: 4.5,
  );

  test('should cache and retrieve products correctly', () {
    dataSource.cacheProducts([product]);
    final result = dataSource.getCachedProducts();
    expect(result.length, 1);
    expect(result.first.name, 'Test Product');
  });

  test('should add a product to cache', () {
    dataSource.cacheProducts([]);
    dataSource.addProduct(product);
    final result = dataSource.getCachedProducts();
    expect(result.length, 1);
    expect(result.first.id, 1);
  });

  test('should update a product in cache', () {
    final updatedProduct = Product(
      id: 1,
      name: 'Test Product',
      price: 99.99,
      category: 'Electronics',
      image: 'https://example.com/image.jpg',
      description: 'A nice test product.',
      rating: 4.5,
    );
    dataSource.cacheProducts([product]);
    dataSource.updateProduct(updatedProduct);
    final result = dataSource.getCachedProducts();
    expect(result.first.name, 'Updated');
  });

  test('should delete a product from cache', () {
    dataSource.cacheProducts([product]);
    dataSource.deleteProduct(1);
    final result = dataSource.getCachedProducts();
    expect(result.length, 0);
  });
}
