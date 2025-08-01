import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../dummy_products.dart';

class InMemoryProductRepository implements ProductRepository {
  final List<Product> _products;

  InMemoryProductRepository() : _products = List<Product>.from(dummyProducts);

  @override
  List<Product> getAllProducts() => List.unmodifiable(_products);

  @override
  Product? getProductById(int id) =>
      _products.firstWhere((p) => p.id == id, orElse: () => Product.empty());

  @override
  void addProduct(Product product) {
    _products.add(product);
  }

  @override
  void updateProduct(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) _products[index] = product;
  }

  @override
  void deleteProduct(int id) {
    _products.removeWhere((p) => p.id == id);
  }
}
