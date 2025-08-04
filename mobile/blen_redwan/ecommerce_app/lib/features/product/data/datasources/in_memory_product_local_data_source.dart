import '../../domain/entities/product.dart';
import 'product_local_data_source.dart';
import '../dummy_products.dart';

class InMemoryProductLocalDataSource implements ProductLocalDataSource {
  final List<Product> _products = List<Product>.from(dummyProducts);

  @override
  List<Product> getCachedProducts() => List.unmodifiable(_products);

  @override
  void cacheProducts(List<Product> products) {
    _products.clear();
    _products.addAll(products);
  }

  @override
  void addProduct(Product product) {
    _products.add(product);
  }

  @override
  void updateProduct(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
    }
  }

  @override
  void deleteProduct(int id) {
    _products.removeWhere((p) => p.id == id);
  }
}
