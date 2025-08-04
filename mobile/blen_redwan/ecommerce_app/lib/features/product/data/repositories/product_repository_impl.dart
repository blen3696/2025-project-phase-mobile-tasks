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
    if (await networkInfo.isConnected) {
      final remoteProducts = await remoteDataSource.fetchAllProducts();
      localDataSource.cacheProducts(remoteProducts);
      return remoteProducts;
    } else {
      return localDataSource.getCachedProducts();
    }
  }

  @override
  Future<Product?> getProductById(int id) async {
    if (await networkInfo.isConnected) {
      final product = await remoteDataSource.fetchProductById(id);
      return product;
    } else {
      return localDataSource.getCachedProducts().firstWhere(
        (p) => p.id == id,
        orElse: () => Product.empty(),
      );
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
