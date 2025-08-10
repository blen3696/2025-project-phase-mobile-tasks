import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl(this.client);

  final String baseUrl =
      'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v2';

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login'),
      body: {'email': email, 'password': password},
    );
    final jsonData = json.decode(response.body);
    return UserModel.fromJson(jsonData['data']);
  }

  @override
  Future<UserModel> signup(String name, String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      final data = jsonData['data'];

      if (data == null) {
        throw Exception('No data in response');
      }
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to signup with status: ${response.statusCode}');
    }
  }
}
