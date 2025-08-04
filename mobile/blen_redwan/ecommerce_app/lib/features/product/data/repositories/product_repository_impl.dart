import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';
import '../../../../core/network/network_info.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Product>> getAllProducts() async {
    final connected = await networkInfo.isConnected;

    if (connected) {
      try {
        final remoteProducts = await remoteDataSource.fetchAllProducts();
        localDataSource.cacheProducts(remoteProducts);
        return remoteProducts;
      } catch (e) {
        throw Exception('Failed to fetch products from remote: $e');
      }
    } else {
      final cached = localDataSource.getCachedProducts();
      if (cached.isNotEmpty) {
        return cached;
      } else {
        throw Exception('No internet connection and no cached data available.');
      }
    }
  }

  @override
  Future<Product?> getProductById(int id) async {
    final connected = await networkInfo.isConnected;

    if (connected) {
      try {
        final product = await remoteDataSource.fetchProductById(id);
        return product;
      } catch (e) {
        throw Exception('Failed to fetch product from remote: $e');
      }
    } else {
      final cachedProducts = localDataSource.getCachedProducts();
      final localProduct = cachedProducts.firstWhere(
        (p) => p.id == id,
        orElse: () => Product.empty(),
      );

      if (localProduct == Product.empty()) {
        throw Exception('No internet and product not found in cache.');
      }

      return localProduct;
    }
  }

  @override
  Future<void> addProduct(Product product) async {
    localDataSource.addProduct(product);
  }

  @override
  Future<void> updateProduct(Product product) async {
    localDataSource.updateProduct(product);
  }

  @override
  Future<void> deleteProduct(int id) async {
    localDataSource.deleteProduct(id);
  }
}
