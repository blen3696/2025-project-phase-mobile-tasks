// lib/features/products/data/repositories/product_repository_impl.dart
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../dummy_products.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource local;
  List<Product>? _memory;

  ProductRepositoryImpl({required this.local});

  Future<void> _ensureInitialized() async {
    if (_memory != null) return;
    final cached = local.getCachedProducts();
    if (cached.isEmpty) {
      local.cacheProducts(dummyProducts);
      _memory = List<Product>.from(dummyProducts);
    } else {
      _memory = List<Product>.from(cached);
    }
  }

  Future<void> _persist() async {
    if (_memory != null) {
      local.cacheProducts(_memory!);
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    await _ensureInitialized();
    return List<Product>.unmodifiable(_memory!);
  }

  @override
  Future<Product?> getProductById(int id) async {
    await _ensureInitialized();
    try {
      return _memory!.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> addProduct(Product product) async {
    await _ensureInitialized();
    _memory!.add(product);
    await _persist();
  }

  @override
  Future<void> updateProduct(Product product) async {
    await _ensureInitialized();
    final idx = _memory!.indexWhere((p) => p.id == product.id);
    if (idx != -1) {
      _memory![idx] = product;
      await _persist();
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    await _ensureInitialized();
    _memory!.removeWhere((p) => p.id == id);
    await _persist();
  }
}
