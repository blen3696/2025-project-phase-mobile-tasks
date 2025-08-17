// lib/features/products/app/products_service.dart
import 'dart:io';
import '../data/datasources/product_remote_data_source_impl.dart';
import '../domain/entities/product.dart';

class ProductsService {
  static final ProductsService _instance = ProductsService._internal();
  factory ProductsService() => _instance;
  ProductsService._internal();

  late final ProductRemoteDataSourceImpl _remoteDataSource;

  static const String _baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v2';
  static const String _token = 'token';

  void init() {
    _remoteDataSource = ProductRemoteDataSourceImpl(
      baseUrl: _baseUrl,
      token: _token,
    );
  }

  /// Fetch all products
  Future<List<Product>> getAll() => _remoteDataSource.fetchAllProducts();

  /// Fetch single product by id
  Future<Product?> getById(String id) =>
      _remoteDataSource.fetchProductById(id as int);

  /// Create product
  Future<Product?> create(Product p, {File? image}) =>
      _remoteDataSource.createProduct(
        name: p.name,
        description: p.description,
        price: p.price,
        image: image,
      );

  /// Update product
  Future<void> update(Product p, {File? image}) =>
      _remoteDataSource.updateProduct(
        id: p.id.toString(),
        name: p.name,
        description: p.description,
        price: p.price,
        image: image,
      );

  /// Delete product
  Future<void> delete(String id) => _remoteDataSource.deleteProduct(id);
}
