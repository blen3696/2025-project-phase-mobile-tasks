import '../../domain/entities/product.dart';

abstract class ProductLocalDataSource {
  List<Product> getCachedProducts();
  void cacheProducts(List<Product> products);
  void addProduct(Product product);
  void updateProduct(Product product);
  void deleteProduct(int id);
}
