import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';
import 'product_local_data_source.dart';
import '../../domain/entities/product.dart';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  static const String _cachedKey = 'CACHED_PRODUCTS';
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  List<Product> getCachedProducts() {
    final jsonString = sharedPreferences.getString(_cachedKey);
    if (jsonString != null) {
      final List<dynamic> decoded = json.decode(jsonString);
      return decoded.map((item) => ProductModel.fromJson(item)).toList();
    }
    return [];
  }

  @override
  void cacheProducts(List<Product> products) {
    final jsonList = products
        .map(
          (p) => ProductModel(
            id: p.id,
            name: p.name,
            description: p.description,
            price: p.price,
            image: p.image,
            rating: p.rating,
            category: p.category,
          ).toJson(),
        )
        .toList();
    sharedPreferences.setString(_cachedKey, json.encode(jsonList));
  }

  @override
  void addProduct(Product product) {
    final current = getCachedProducts();
    current.add(product);
    cacheProducts(current);
  }

  @override
  void updateProduct(Product product) {
    final current = getCachedProducts();
    final index = current.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      current[index] = product;
      cacheProducts(current);
    }
  }

  @override
  void deleteProduct(int id) {
    final current = getCachedProducts();
    current.removeWhere((p) => p.id == id);
    cacheProducts(current);
  }
}
