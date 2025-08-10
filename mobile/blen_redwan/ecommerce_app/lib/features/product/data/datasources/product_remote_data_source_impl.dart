import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/product.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  ProductRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<List<Product>> fetchAllProducts() async {
    final response = await client.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> decoded = json.decode(response.body);
      return decoded.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception(
        'Failed to fetch products. Status: ${response.statusCode}',
      );
    }
  }

  @override
  Future<Product?> fetchProductById(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      return Product.fromJson(decoded);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception(
        'Failed to fetch product. Status: ${response.statusCode}',
      );
    }
  }
}
