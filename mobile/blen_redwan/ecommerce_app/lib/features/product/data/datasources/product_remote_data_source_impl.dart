import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final String baseUrl;
  final String token;

  ProductRemoteDataSourceImpl({required this.baseUrl, required this.token});

  Map<String, String> get _headers => {'Authorization': 'Bearer $token'};

  @override
  Future<List<ProductModel>> fetchAllProducts() async {
    final url = Uri.parse('$baseUrl/products');
    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  @override
  Future<ProductModel?> fetchProductById(int id) async {
    final url = Uri.parse('$baseUrl/products/$id');
    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  Future<ProductModel?> createProduct({
    required String name,
    required String description,
    required double price,
    File? image,
  }) async {
    final url = Uri.parse('$baseUrl/products');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(_headers);
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['price'] = price.toString();
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      final data = json.decode(response.body)['data'];
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed to create product');
    }
  }

  Future<void> updateProduct({
    required String id,
    String? name,
    String? description,
    double? price,
    File? image,
  }) async {
    final url = Uri.parse('$baseUrl/products/$id');
    var request = http.MultipartRequest('PATCH', url);
    request.headers.addAll(_headers);
    if (name != null) request.fields['name'] = name;
    if (description != null) request.fields['description'] = description;
    if (price != null) request.fields['price'] = price.toString();
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse('$baseUrl/products/$id');
    final response = await http.delete(url, headers: _headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}
