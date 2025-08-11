import 'package:jwt_decoder/jwt_decoder.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.name, required super.email, required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final token = json['access_token'] ?? '';

    final decoded = token.isNotEmpty ? JwtDecoder.decode(token) : {};

    return UserModel(
      name: decoded['name'] ?? '',
      email: decoded['email'] ?? '',
      token: token,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'token': token};
  }
}
