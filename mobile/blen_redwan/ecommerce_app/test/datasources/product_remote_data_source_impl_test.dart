import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_data_source_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

void main() {
  late ProductRemoteDataSourceImpl dataSource;

  final mockProduct = Product(
    id: 1,
    name: 'Test Product',
    price: 49.99,
    category: 'Electronics',
    image: 'https://example.com/image.jpg',
    description: 'A test product',
    rating: 4.3,
  );

  final jsonProduct = mockProduct.toJson();

  setUp(() {
    dataSource = ProductRemoteDataSourceImpl(
      client: MockClient((request) async {
        if (request.url.path == '/products') {
          return http.Response(json.encode([jsonProduct]), 200);
        } else if (request.url.path == '/products/1') {
          return http.Response(json.encode(jsonProduct), 200);
        } else {
          return http.Response('Not Found', 404);
        }
      }),
      baseUrl: 'https://fakeapi.com',
    );
  });

  test('fetchAllProducts returns list of products', () async {
    final products = await dataSource.fetchAllProducts();
    expect(products.length, 1);
    expect(products.first.name, 'Test Product');
  });

  test('fetchProductById returns single product', () async {
    final product = await dataSource.fetchProductById(1);
    expect(product?.id, 1);
    expect(product?.name, 'Test Product');
  });

  test('fetchProductById returns null if not found', () async {
    final product = await dataSource.fetchProductById(999);
    expect(product, null);
  });
}
