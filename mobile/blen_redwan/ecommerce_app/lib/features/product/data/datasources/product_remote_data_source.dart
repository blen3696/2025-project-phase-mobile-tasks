import '../../domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> fetchAllProducts();
  Future<Product?> fetchProductById(int id);
}
