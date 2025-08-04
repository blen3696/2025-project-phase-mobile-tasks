import '../../domain/entities/product.dart';
import 'product_remote_data_source.dart';
import '../dummy_products.dart';

class MockRemoteProductDataSource implements ProductRemoteDataSource {
  @override
  Future<List<Product>> fetchAllProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return dummyProducts;
  }

  @override
  Future<Product?> fetchProductById(int id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return dummyProducts.firstWhere(
      (product) => product.id == id,
      orElse: () => Product.empty(),
    );
  }
}
