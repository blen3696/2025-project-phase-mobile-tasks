import '../entities/product.dart';

abstract class ProductRepository {
  List<Product> getAllProducts();
  Product? getProductById(int id);
  void addProduct(Product product);
  void updateProduct(Product product);
  void deleteProduct(int id);
}
