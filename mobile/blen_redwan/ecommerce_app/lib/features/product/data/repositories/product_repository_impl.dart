import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({required this.localDataSource});

  @override
  List<Product> getAllProducts() => localDataSource.getCachedProducts();

  @override
  Product? getProductById(int id) => localDataSource
      .getCachedProducts()
      .firstWhere((product) => product.id == id, orElse: () => Product.empty());

  @override
  void addProduct(Product product) => localDataSource.addProduct(product);

  @override
  void updateProduct(Product product) => localDataSource.updateProduct(product);

  @override
  void deleteProduct(int id) => localDataSource.deleteProduct(id);
}
