import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/message_model.dart';
import 'chat_socket_service.dart';

abstract class ChatRemoteDataSource {
  Future<void> connectSocket();
  void sendMessage(String chatId, String content);
  Stream<MessageModel> get onMessageReceived;
  Stream<MessageModel> get onMessageDelivered;
  Future<List<dynamic>> fetchChats();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ChatSocketService socketService;
  final http.Client client;
  final baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v3';

  ChatRemoteDataSourceImpl(this.socketService, this.client);

  @override
  Future<void> connectSocket() => socketService.connect();

  @override
  void sendMessage(String chatId, String content) {
    final payload = {'chatId': chatId, 'content': content, 'type': 'text'};
    socketService.emitMessageSend(payload);
  }

  @override
  Stream<MessageModel> get onMessageReceived =>
      socketService.receivedStream.map((m) => MessageModel.fromMessage(m));

  @override
  Stream<MessageModel> get onMessageDelivered =>
      socketService.deliveredStream.map((m) => MessageModel.fromMessage(m));

  @override
  Future<List<dynamic>> fetchChats() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token') ?? '';
    final res = await client.get(
      Uri.parse('$baseUrl/chats'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      if (body is Map && body.containsKey('data')) {
        return body['data'] as List<dynamic>;
      } else if (body is List) {
        return body;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load chats: ${res.statusCode}');
    }
  }
}
